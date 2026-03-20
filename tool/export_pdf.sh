#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TYP_DIR="${ROOT_DIR}/typ"
PDF_DIR="${ROOT_DIR}/pdf"

usage() {
  cat <<'USAGE'
用法:
  ./tool/export_pdf.sh               # 导出 typ/ 下全部 .typ 到 pdf/
  ./tool/export_pdf.sh <模板文件>    # 导出单个模板（支持 typ/name.typ 或 name.typ）

示例:
  ./tool/export_pdf.sh
  ./tool/export_pdf.sh color_cards.typ
  ./tool/export_pdf.sh typ/color_cards.typ
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

mkdir -p "${PDF_DIR}"

if command -v tinymist >/dev/null 2>&1 && tinymist compile --help >/dev/null 2>&1; then
  COMPILER=(tinymist compile)
  COMPILER_NAME="tinymist"
elif [[ -x "${ROOT_DIR}/.local/bin/tinymist" ]] \
  && "${ROOT_DIR}/.local/bin/tinymist" compile --help >/dev/null 2>&1; then
  COMPILER=("${ROOT_DIR}/.local/bin/tinymist" compile)
  COMPILER_NAME="tinymist(local)"
elif command -v typst >/dev/null 2>&1; then
  COMPILER=(typst compile)
  COMPILER_NAME="typst"
else
  echo "错误: 未找到 tinymist 或 typst 命令。" >&2
  echo "请先安装其中之一后重试。" >&2
  exit 1
fi

echo "使用编译器: ${COMPILER_NAME}"

declare -a files

if [[ $# -gt 1 ]]; then
  echo "错误: 参数过多。" >&2
  usage
  exit 1
elif [[ $# -eq 1 ]]; then
  input="$1"
  case "${input}" in
    typ/*.typ)
      src="${ROOT_DIR}/${input}"
      ;;
    *.typ)
      src="${TYP_DIR}/${input}"
      ;;
    *)
      src="${TYP_DIR}/${input}.typ"
      ;;
  esac

  if [[ ! -f "${src}" ]]; then
    echo "错误: 找不到模板文件: ${input}" >&2
    exit 1
  fi

  files=("${src}")
else
  mapfile -t files < <(find "${TYP_DIR}" -maxdepth 1 -type f -name '*.typ' | sort)
  if [[ ${#files[@]} -eq 0 ]]; then
    echo "错误: ${TYP_DIR} 下没有 .typ 文件。" >&2
    exit 1
  fi
fi

ok=0
fail=0

for src in "${files[@]}"; do
  base="$(basename "${src}" .typ)"
  out="${PDF_DIR}/${base}.pdf"
  echo "编译: ${src} -> ${out}"

  if "${COMPILER[@]}" "${src}" "${out}"; then
    ((ok += 1))
  else
    ((fail += 1))
    echo "失败: ${src}" >&2
  fi
done

echo "完成: 成功 ${ok} 个, 失败 ${fail} 个。输出目录: ${PDF_DIR}"

if [[ ${fail} -gt 0 ]]; then
  exit 1
fi
