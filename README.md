# 轻松戒色 (EasyPeasy)

[EasyPeasy](https://easypeasymethod.org/) 的中文翻译版本，帮助读者无需意志力、无痛苦地永久戒除色情成瘾。

## 在线阅读

本书以 [Jekyll Chapterbook](https://github.com/jasongrimes/jekyll-chapterbook) 主题发布，通过 GitHub Pages 提供在线阅读。GitHub Pages 直接从 `master` 分支的 `docs/` 目录读取 Jekyll 源文件并自动构建，无需额外的构建流程。

**在线阅读地址：** https://0bo.github.io/easypeasy/

## 部署方案说明

本项目采用 **方案一：GitHub Pages 直接从主目录读取文件生成 Pages**：

- Jekyll 网站源文件位于 `docs/` 目录
- GitHub Pages 设置为从 `master` 分支的 `docs/` 目录提供服务
- GitHub Pages 自动构建 Jekyll（使用 `remote_theme: jasongrimes/jekyll-chapterbook`）
- 无需维护 CI/CD 流程，推送到 `master` 即可自动发布

**方案对比：**

| 方案 | 说明 | 优点 | 缺点 |
|------|------|------|------|
| 从主分支 `docs/` 直接发布 ✅ | GitHub Pages 直接构建 Jekyll | 最简单、无需 CI/CD、即时发布 | 需要将 Jekyll 源文件提交到仓库 |
| 构建后发布到 `gh-pages` 分支 | CI/CD 构建后推送到独立分支 | 灵活、构建工具不受限 | 需要维护 CI/CD 流程 |

**选择理由：** `jekyll-chapterbook` 无需自定义插件，GitHub Pages 原生支持，采用方案一更简洁、易维护。

## 项目结构

```
docs/               # Jekyll 网站（GitHub Pages 从此目录提供服务）
├── _config.yml     # Jekyll 配置（使用 jekyll-chapterbook 主题）
├── _chapters/      # 各章节 Markdown 文件
│   ├── 000-front/  # 前言
│   ├── 010-*.md    # 第 1 章 ～ 第 31 章
│   └── 999-back/   # 附录
├── _pages/         # 其他页面（目录等）
├── assets/         # 图片、资源文件
└── index.md        # 首页

*.Rmd               # 章节源文件（R Markdown 格式）
easypeasy.pdf       # 生成的 PDF 版本
```

## 本地开发

### 预览 Jekyll 网站

```bash
cd docs
bundle install
bundle exec jekyll serve
```

然后在浏览器中打开 http://localhost:4000/

### 构建 PDF

PDF 由 GitHub Actions 在推送到 `master` 时自动生成。如需本地构建：

```bash
# 需要安装 pandoc 和 texlive
pandoc index.Rmd [0-9]*.Rmd \
  -o easypeasy.pdf \
  --pdf-engine=xelatex \
  -V CJKmainfont="Noto Sans CJK SC"
```

## 贡献

欢迎提交 Pull Request 改进内容。各章节的 Markdown 源文件位于 `docs/_chapters/` 目录。

## 许可证

本作品采用 [知识共享署名-相同方式共享 4.0 国际许可证](https://creativecommons.org/licenses/by-sa/4.0/) 进行许可。
