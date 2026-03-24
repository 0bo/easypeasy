# 轻松戒色 (EasyPeasy)

[EasyPeasy](https://easypeasymethod.org/) 的中文翻译版本，帮助读者无需意志力、无痛苦地永久戒除色情成瘾。

## 在线阅读

本书以 [Jekyll Chapterbook](https://github.com/jasongrimes/jekyll-chapterbook) 主题发布，通过 GitHub Pages 提供在线阅读。GitHub Pages 直接从 `master` 分支根目录的 Jekyll 源文件自动构建，无需额外的构建流程。

**在线阅读地址：** https://0bo.github.io/easypeasy/

## 部署方案

本项目采用 **GitHub Pages 直接从主分支根目录发布**：

- Jekyll 网站源文件直接位于根目录
- GitHub Pages 设置为从 `master` 分支根目录（`/`）提供服务
- GitHub Pages 自动构建 Jekyll（使用 `remote_theme: jasongrimes/jekyll-chapterbook`）
- 推送到 `master` 即可自动发布，无需维护 CI/CD 构建流程

## 项目结构

```
_chapters/          # 各章节 Markdown 文件
├── 000-front/      # 前言
│   └── 010-introduction.md
├── 010-*.md        # 第 1 章 ～ 第 31 章
└── 999-back/       # 附录
    └── 010-resources.md

_pages/             # 其他页面（目录等）
assets/             # 图片、资源文件
├── images/
└── resources/

_config.yml         # Jekyll 配置（使用 jekyll-chapterbook 主题）
index.md            # 首页
Gemfile             # 本地开发依赖
easypeasy.pdf       # 生成的 PDF 版本
```

## 本地开发

### 预览 Jekyll 网站

```bash
bundle install
bundle exec jekyll serve
```

然后在浏览器中打开 http://localhost:4000/

### 构建 PDF

PDF 由 GitHub Actions 在推送到 `master` 时自动生成（读取 `_chapters/` 下的 Markdown 文件）。如需本地构建：

```bash
# 需要安装 pandoc 和 texlive
chapters=$(find _chapters -name '*.md' | sort)
pandoc $chapters \
  -o easypeasy.pdf \
  --pdf-engine=xelatex \
  -V CJKmainfont="Noto Sans CJK SC"
```

## 贡献

欢迎提交 Pull Request 改进内容。各章节的 Markdown 源文件位于 `_chapters/` 目录。

## 许可证

本作品采用 [知识共享署名-相同方式共享 4.0 国际许可证](https://creativecommons.org/licenses/by-sa/4.0/) 进行许可。
