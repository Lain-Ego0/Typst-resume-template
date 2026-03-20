#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
PDF_DIR="${ROOT_DIR}/pdf"
IMG_DIR="${ROOT_DIR}/images"

dpi=200
all_pages=0

inputs=()
files=()

usage() {
  cat <<'USAGE'
用法:
  ./tool/pdf_to_images.sh [选项] [PDF文件 ...]

说明:
  不传 PDF 文件时，默认转换 pdf/ 下全部 .pdf。
  默认只导出每个 PDF 的第 1 页到 images/<name>_page_1.png。

选项:
  -r, --dpi <数值>   设置分辨率 DPI（默认 200）
  -a, --all-pages    导出全部页（文件名为 images/<name>_page-1.png 等）
  -h, --help         显示帮助

示例:
  ./tool/pdf_to_images.sh
  ./tool/pdf_to_images.sh -r 300
  ./tool/pdf_to_images.sh -r 260 no_profile_picture.pdf
  ./tool/pdf_to_images.sh -a -r 220 pdf/with_profile_picture.pdf
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
      while [[ $# -gt 0 ]]; do
        inputs+=("$1")
        shift
      done
      ;;
    -*)
      echo "错误: 未知选项: $1" >&2
      usage
      exit 1
      ;;
    *)
      inputs+=("$1")
      shift
      ;;
  esac
done

if ! [[ "${dpi}" =~ ^[1-9][0-9]*$ ]]; then
  echo "错误: DPI 必须是正整数，当前为: ${dpi}" >&2
  exit 1
fi

if ! command -v pdftoppm >/dev/null 2>&1; then
  echo "错误: 未找到 pdftoppm。请先安装 poppler-utils。" >&2
  exit 1
fi

mkdir -p "${IMG_DIR}"

if [[ ${#inputs[@]} -eq 0 ]]; then
  mapfile -t files < <(find "${PDF_DIR}" -maxdepth 1 -type f -name '*.pdf' | sort)
else
  for input in "${inputs[@]}"; do
    case "${input}" in
      /*.pdf)
        src="${input}"
        ;;
      pdf/*.pdf)
        src="${ROOT_DIR}/${input}"
        ;;
      *.pdf)
        if [[ -f "${PDF_DIR}/${input}" ]]; then
          src="${PDF_DIR}/${input}"
        elif [[ -f "${ROOT_DIR}/${input}" ]]; then
          src="${ROOT_DIR}/${input}"
        else
          src="${PDF_DIR}/${input}"
        fi
        ;;
      *)
        src="${PDF_DIR}/${input}.pdf"
        ;;
    esac

    if [[ ! -f "${src}" ]]; then
      echo "错误: 找不到 PDF 文件: ${input}" >&2
      exit 1
    fi

    files+=("${src}")
  done
fi

if [[ ${#files[@]} -eq 0 ]]; then
  echo "错误: ${PDF_DIR} 下没有 .pdf 文件。" >&2
  exit 1
fi

echo "使用分辨率: ${dpi} DPI"

ok=0
fail=0

for src in "${files[@]}"; do
  base="$(basename "${src}" .pdf)"

  if [[ ${all_pages} -eq 1 ]]; then
    prefix="${IMG_DIR}/${base}_page"
    echo "转换(全部页): ${src} -> ${prefix}-N.png"
    if pdftoppm -png -r "${dpi}" "${src}" "${prefix}"; then
      ((ok += 1))
    else
      ((fail += 1))
      echo "失败: ${src}" >&2
    fi
  else
    prefix="${IMG_DIR}/${base}_page_1"
    out="${prefix}.png"
    echo "转换(第1页): ${src} -> ${out}"
    if pdftoppm -png -r "${dpi}" -f 1 -l 1 -singlefile "${src}" "${prefix}"; then
      ((ok += 1))
    else
      ((fail += 1))
      echo "失败: ${src}" >&2
    fi
  fi
done

echo "完成: 成功 ${ok} 个, 失败 ${fail} 个。输出目录: ${IMG_DIR}"

if [[ ${fail} -gt 0 ]]; then
  exit 1
fi
