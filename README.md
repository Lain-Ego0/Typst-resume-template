# Typst 中文简历模板库

这个仓库包含多套可直接修改的 Typst 简历模板，并提供 PDF 导出与图片转换脚本。

## 目录结构

```text
Typst-resume-template/
├─ typ/      模板文件（直接改这里）
├─ tool/     工具脚本（PDF 导出 / PDF 转图片 / 一键全流程）
├─ images/   头像图片（可选）
├─ pdf/      导出的 PDF（建议输出到这里）
└─ README.md
```

## 模板总览

### A. 基础模板

- `typ/no_profile_picture.typ`
- `typ/with_profile_picture.typ`
- `typ/resume_classic_with_photo.typ`
- `typ/sidebar_tech_blue.typ`
- `typ/minimal_ats.typ`
- `typ/color_cards.typ`
- `typ/newspaper_two_column.typ`
- `typ/ribbon_section_blocks.typ`
- `typ/bracket_index_titles.typ`
- `typ/split_banner_titles.typ`
- `typ/side_label_titles.typ`

### B. 扩展模板

- `typ/ref_golixp_resume_zh_cn.typ`
- `typ/ref_typst_project_rw1SLr0IIZZnCrkrsypRQF.typ`
- `typ/ref_uniquecv_typst.typ`
- `typ/ref_typst_cv_miku.typ`
- `typ/ref_alta_typst.typ`
- `typ/ref_attractive_typst_resume.typ`
- `typ/ref_moderncv_typst.typ`
- `typ/ref_resume_typ.typ`
- `typ/ref_chicv.typ`
- `typ/ref_bamboovir_typst_resume_template.typ`
- `typ/ref_brilliant_cv.typ`
- `typ/ref_chinese_resume_in_typst.typ`

## 预览

| 标题 | 标题 | 标题 |
| --- | --- | --- |
| bracket_index_titles | color_cards | minimal_ats |
| ![bracket_index_titles](images/bracket_index_titles_page_1.png) | ![color_cards](images/color_cards_page_1.png) | ![minimal_ats](images/minimal_ats_page_1.png) |
| newspaper_two_column | no_profile_picture | ref_alta_typst |
| ![newspaper_two_column](images/newspaper_two_column_page_1.png) | ![no_profile_picture](images/no_profile_picture_page_1.png) | ![ref_alta_typst](images/ref_alta_typst_page_1.png) |
| ref_attractive_typst_resume | ref_bamboovir_typst_resume_template | ref_brilliant_cv |
| ![ref_attractive_typst_resume](images/ref_attractive_typst_resume_page_1.png) | ![ref_bamboovir_typst_resume_template](images/ref_bamboovir_typst_resume_template_page_1.png) | ![ref_brilliant_cv](images/ref_brilliant_cv_page_1.png) |
| ref_chicv | ref_chinese_resume_in_typst | ref_golixp_resume_zh_cn |
| ![ref_chicv](images/ref_chicv_page_1.png) | ![ref_chinese_resume_in_typst](images/ref_chinese_resume_in_typst_page_1.png) | ![ref_golixp_resume_zh_cn](images/ref_golixp_resume_zh_cn_page_1.png) |
| ref_moderncv_typst | ref_resume_typ | ref_typst_cv_miku |
| ![ref_moderncv_typst](images/ref_moderncv_typst_page_1.png) | ![ref_resume_typ](images/ref_resume_typ_page_1.png) | ![ref_typst_cv_miku](images/ref_typst_cv_miku_page_1.png) |
| ref_typst_project_rw1SLr0IIZZnCrkrsypRQF | ref_uniquecv_typst | resume_classic_with_photo |
| ![ref_typst_project_rw1SLr0IIZZnCrkrsypRQF](images/ref_typst_project_rw1SLr0IIZZnCrkrsypRQF_page_1.png) | ![ref_uniquecv_typst](images/ref_uniquecv_typst_page_1.png) | ![resume_classic_with_photo](images/resume_classic_with_photo_page_1.png) |
| sidebar_tech_blue | side_label_titles | split_banner_titles |
| ![sidebar_tech_blue](images/sidebar_tech_blue_page_1.png) | ![side_label_titles](images/side_label_titles_page_1.png) | ![split_banner_titles](images/split_banner_titles_page_1.png) |
| with_profile_picture |  |  |
| ![with_profile_picture](images/with_profile_picture_page_1.png) |  |  |

## 快速使用

1. 打开任意 `typ/*.typ` 文件。
2. 替换姓名、电话、邮箱、教育/项目经历。
3. 导出 PDF。

### 一键导出

项目已提供脚本：`tool/export_pdf.sh`

```bash
# 导出 typ/ 下全部模板到 pdf/
./tool/export_pdf.sh

# 只导出单个模板（两种写法都支持）
./tool/export_pdf.sh color_cards.typ
./tool/export_pdf.sh typ/color_cards.typ
```

脚本会优先使用 `tinymist compile`，若不可用则自动回退到 `typst compile`。

示例：

```bash
typst compile typ/ref_uniquecv_typst.typ pdf/ref_uniquecv_typst.pdf
```

批量编译所有 `ref_` 模板：

```bash
mkdir -p pdf
for f in typ/ref_*.typ; do
  name=$(basename "${f%.typ}")
  typst compile "$f" "pdf/${name}.pdf"
done
```

## 依赖安装

### 1) Typst CLI

macOS（Homebrew）：

```bash
brew install typst
```

跨平台（已安装 Rust/Cargo）：

```bash
cargo install --locked typst-cli
```

或者直接使用VS Code 插件：`Tinymist Typst`

### 2) 字体下载与安装

> 下面命令覆盖了这些模板常见字体：
> Noto/Source Han CJK、IBM Plex、Roboto、Source Sans、Mulish、Nerd Font Symbols。

下载到项目内 `fonts/`：

```bash
mkdir -p fonts && cd fonts

curl -L -o source-han-sans-sc.zip \
  https://github.com/adobe-fonts/source-han-sans/releases/latest/download/SourceHanSansSC.zip

curl -L -o source-han-serif-cn.zip \
  https://github.com/adobe-fonts/source-han-serif/releases/latest/download/12_SourceHanSerifCN.zip

curl -L -o nerd-font-symbols.zip \
  https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip

curl -L -o roboto.zip "https://fonts.google.com/download?family=Roboto"
curl -L -o source-sans-3.zip "https://fonts.google.com/download?family=Source%20Sans%203"
curl -L -o source-sans-pro.zip "https://fonts.google.com/download?family=Source%20Sans%20Pro"
curl -L -o mulish.zip "https://fonts.google.com/download?family=Mulish"
curl -L -o ibm-plex-sans.zip "https://fonts.google.com/download?family=IBM%20Plex%20Sans"
curl -L -o ibm-plex-serif.zip "https://fonts.google.com/download?family=IBM%20Plex%20Serif"
curl -L -o ibm-plex-mono.zip "https://fonts.google.com/download?family=IBM%20Plex%20Mono"
```

安装到 Linux 用户字体目录：

```bash
mkdir -p ~/.local/share/fonts/typst-resume
for z in fonts/*.zip; do
  unzip -o "$z" -d ~/.local/share/fonts/typst-resume
done
fc-cache -f -v
```

### 3) `typst-cv-miku` 里提到的 `kpfonts`（可选）

如果你要尽量贴近该项目原效果：

```bash
# 需要 TeX Live
tlmgr install kpfonts
```

## 进阶

### 1) 仓库内安装 Tinymist（不依赖全局环境）

适合不想改系统环境，或在受限环境（如部分 Snap 会话）里使用：

```bash
mkdir -p .local/bin .local/config
curl --proto '=https' --tlsv1.2 -LsSf \
  https://github.com/Myriad-Dreamin/tinymist/releases/latest/download/tinymist-installer.sh \
  | XDG_BIN_HOME="$(pwd)/.local/bin" \
    XDG_CONFIG_HOME="$(pwd)/.local/config" \
    TINYMIST_NO_MODIFY_PATH=1 sh
```

### 2) 使用本地 Tinymist 一键导出 PDF

```bash
PATH="$(pwd)/.local/bin:$PATH" ./tool/export_pdf.sh
```

### 3) PDF 转图片

需要 `pdftoppm`（Linux 通常来自 `poppler-utils` 包）。

```bash
# 把 pdf/ 下所有 PDF 的第 1 页转成 PNG（默认 200 DPI）
./tool/pdf_to_images.sh

# 指定分辨率（例如 300 DPI）
./tool/pdf_to_images.sh -r 300

# 只转换单个 PDF（支持两种写法）
./tool/pdf_to_images.sh -r 260 no_profile_picture.pdf
./tool/pdf_to_images.sh -r 260 pdf/no_profile_picture.pdf

# 导出全部页
./tool/pdf_to_images.sh -a -r 220 with_profile_picture.pdf
```

### 4) 可选：为当前终端会话设置 PATH

```bash
export PATH="$(pwd)/.local/bin:$PATH"
./tool/export_pdf.sh
```

### 5) 一条命令执行导出 PDF + 转图片

```bash
# 全部模板 + 全部 PDF 第1页转图
./tool/run_all.sh

# 自定义图片分辨率
./tool/run_all.sh -r 300

# 只处理一个模板
./tool/run_all.sh -r 260 color_cards.typ

# 导出全部页
./tool/run_all.sh -a -r 220 typ/with_profile_picture.typ
```

## 常见问题

### 1. `unknown font family`

系统没装对应字体。先执行上面的字体下载与安装命令，或者把模板中的字体改成你机器已有字体。

### 2. `image not found`

检查头像路径与文件名是否一致，建议使用 `images/image.png`。

### 3. 看不到预览

在 VS Code 执行 `Typst: Open Preview`。

## 说明

- 新增的 12 个 `ref_*.typ` 用于统一维护与二次修改。
- 为了减少环境差异，模板都设置了字体回退列表；若你已安装对应字体，显示会更接近参考项目。
- 如果未安装推荐字体，`typst compile` 可能给出 `unknown font family` warning，但模板仍可正常编译。

## 致谢

### 参考

- golixp-resume-zh-cn: <https://typst.app/universe/package/golixp-resume-zh-cn/>
- typst project rw1SLr0IIZZnCrkrsypRQF: <https://typst.app/project/rw1SLr0IIZZnCrkrsypRQF>
- uniquecv-typst: <https://github.com/gaoachao/uniquecv-typst>
- typst-cv-miku: <https://github.com/ice-kylin/typst-cv-miku>
- alta-typst: <https://github.com/GeorgeHoneywood/alta-typst>
- attractive-typst-resume: <https://github.com/Harkunwar/attractive-typst-resume>
- moderncv.typst: <https://github.com/giovanniberti/moderncv.typst>
- resume.typ: <https://github.com/wusyong/resume.typ>
- chicv: <https://github.com/skyzh/chicv>
- bamboovir/typst-resume-template: <https://github.com/bamboovir/typst-resume-template>
- brilliant-CV: <https://github.com/yunanwg/brilliant-CV>
- Chinese-Resume-in-Typst: <https://github.com/OrangeX4/Chinese-Resume-in-Typst>
