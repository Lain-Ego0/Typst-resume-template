#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

dpi=200
all_pages=0
template=""

usage() {
  cat <<'USAGE'
用法:
  ./tool/run_all.sh [选项] [模板文件]

说明:
  一条命令完成两步：
  1) 调用 ./tool/export_pdf.sh 导出 PDF
  2) 调用 ./tool/pdf_to_images.sh 转换图片

  不传模板文件时：导出全部 typ/*.typ，并转换 pdf/ 下全部 PDF。
  传模板文件时：仅处理该模板对应的 PDF。

选项:
  -r, --dpi <数值>   设置转图分辨率 DPI（默认 200）
  -a, --all-pages    转换全部页（默认仅第 1 页）
  -h, --help         显示帮助

示例:
  ./tool/run_all.sh
  ./tool/run_all.sh -r 300
  ./tool/run_all.sh -r 260 color_cards.typ
  ./tool/run_all.sh -a -r 220 typ/with_profile_picture.typ
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    -a|--all-pages)
      all_pages=1
      shift
      ;;
    -r|--dpi)
      if [[ $# -lt 2 ]]; then
        echo "错误: --dpi 需要一个数值参数。" >&2
        exit 1
      fi
      dpi="$2"
      shift 2
      ;;
    --)
      shift
      if [[ $# -gt 0 ]]; then
        template="$1"
        shift
      fi
      ;;
    -*)
      echo "错误: 未知选项: $1" >&2
      usage
      exit 1
      ;;
    *)
      if [[ -n "${template}" ]]; then
        echo "错误: 只能指定一个模板文件。" >&2
        usage
        exit 1
      fi
      template="$1"
      shift
      ;;
  esac
done

if ! [[ "${dpi}" =~ ^[1-9][0-9]*$ ]]; then
  echo "错误: DPI 必须是正整数，当前为: ${dpi}" >&2
  exit 1
fi

if [[ ! -x "${SCRIPT_DIR}/export_pdf.sh" ]]; then
  echo "错误: 找不到可执行脚本: ${SCRIPT_DIR}/export_pdf.sh" >&2
  exit 1
fi

if [[ ! -x "${SCRIPT_DIR}/pdf_to_images.sh" ]]; then
  echo "错误: 找不到可执行脚本: ${SCRIPT_DIR}/pdf_to_images.sh" >&2
  exit 1
fi

derive_pdf_name() {
  local input="$1"
  local name

  case "${input}" in
    typ/*.typ)
      name="$(basename "${input}" .typ)"
      ;;
    *.typ)
      name="$(basename "${input}" .typ)"
      ;;
    *)
      name="$(basename "${input}")"
      ;;
  esac

  printf '%s.pdf\n' "${name}"
}

if [[ -n "${template}" ]]; then
  echo "步骤 1/2: 导出单个模板 PDF -> ${template}"
  "${SCRIPT_DIR}/export_pdf.sh" "${template}"

  target_pdf="$(derive_pdf_name "${template}")"
  echo "步骤 2/2: 转换单个 PDF -> ${target_pdf}"

  cmd=("${SCRIPT_DIR}/pdf_to_images.sh" "-r" "${dpi}")
  if [[ ${all_pages} -eq 1 ]]; then
    cmd+=("-a")
  fi
  cmd+=("${target_pdf}")
  "${cmd[@]}"
else
  echo "步骤 1/2: 导出全部模板 PDF"
  "${SCRIPT_DIR}/export_pdf.sh"

  echo "步骤 2/2: 转换全部 PDF 图片"
  cmd=("${SCRIPT_DIR}/pdf_to_images.sh" "-r" "${dpi}")
  if [[ ${all_pages} -eq 1 ]]; then
    cmd+=("-a")
  fi
  "${cmd[@]}"
fi

echo "全部完成。"
