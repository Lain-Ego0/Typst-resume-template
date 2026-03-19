# Typst 中文简历模板（给非开发者）

这是一个可以直接改内容、导出 PDF 的简历模板库。  
你不需要会编程，按下面步骤操作即可。

## 先看文件夹

```text
Typst-resume-template/
├─ typ/      简历模板（在这里改文字）
├─ images/   头像图片（可选）
├─ pdf/      导出的 PDF（最终投递文件）
└─ README.md
```

## 三个模板怎么选

- `typ/no_profile_picture.typ`：无头像，简洁稳妥，投递系统友好。
- `typ/with_profile_picture.typ`：有头像，信息完整。
- `typ/resume_classic_with_photo.typ`：有头像，偏传统版式。

## 5 分钟使用流程（最简单）

1. 安装 VS Code。
2. 在 VS Code 扩展里安装 `Tinymist Typst`。
3. 打开本项目文件夹。
4. 打开你要用的模板（`typ/` 里的 `.typ` 文件）。
5. 直接替换里面的姓名、电话、邮箱、教育经历、项目经历等内容。
6. 如果要头像，把头像文件放到 `images/` 目录，文件名建议保持 `image.png`。
7. 在 Typst 预览里导出 PDF，并保存到 `pdf/` 目录。

## 头像放置规则（很重要）

- 推荐路径：`images/image.png`
- 模板里头像写法应为：

```typst
#image("../images/image.png", width: 26mm, height: auto)
```

如果你改成了别的文件名，比如 `my_photo.jpg`，就把模板中的路径同步改成：

```typst
#image("../images/my_photo.jpg", width: 26mm, height: auto)
```

## 每次改简历时，照这个顺序

1. 打开 `typ/` 里的模板文件。
2. 只改文字内容，不改排版代码（除非你知道自己在做什么）。
3. 导出 PDF 到 `pdf/`。
4. 打开导出的 PDF 快速检查一遍（错别字、时间、联系方式、分页）。

## 常见问题（直接照做）

### 1. 报错：`unknown font family`

原因：系统没有这个字体。  
处理：把模板里的字体改成你电脑有的字体，推荐保留：

```typst
#set text(font: ("Noto Sans CJK SC"), size: 10.5pt, lang: "zh")
```

### 2. 报错：`image not found`

按顺序检查：

1. 头像是否真的在 `images/` 目录。
2. 文件名是否和模板里完全一致（大小写也要一致）。
3. 模板里的路径是否是 `../images/xxx`。

### 3. 没看到预览窗口

在 VS Code 按 `Ctrl+Shift+P`，输入并执行：`Typst: Open Preview`。

### 4. 信息太长错行了

```typst
columns: (1fr, 1fr, 2fr),
```
这段代码的含义就是下面信息分为三部分以及每部分的比例为1：1：2，如果错行了就放大对应的部分

## 给小白的建议

- 第一次使用，优先选 `no_profile_picture.typ`，最不容易出错。
- 一次只改一个模块，改完就导出 PDF 检查。
- 最终投递前，统一用 `pdf/` 里的文件。
