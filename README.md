# 轻松褪色 (EasyPeasy)--帮你离开网络色情

2026年2月我发现了这本书，偶然。

回忆了如何发现这本书的过程，有点讽刺，但值得记录，因为正是千千万万个这样的机会，让我们最初陷入泥潭，最终在这里相遇。

我在***小众软件***公众号看到了一个网站，[freemediaheckyeah](https://fmhy.net/)，文章的最后暗示了网站有“新天地”的入口，像过去无数宅男/技术宅之间分享“不可言说”的时刻一样。很快，在侧边栏找到了入口，解开了一个根本不算谜题的谜题，找到些大路货色情网站。准备退出的时候，我在那个入口的引导页上看到了一句话：

>If you're struggling with porn addiction, and need help quitting, check out the following section:
>
>Porn Quitting: https://fmhy.net/miscguide#porn-quitting

然后，我找到了这本书，但并没有马上看，因为多年以前我也研究了好久这个问题，Reddit上的NoFap、YourBrainOnPorn网站等等，效果只能说，毫无卵用。

正如文中所写，“如果有用，你也不会来看这本书了”。忘记是哪天了，我再次打开了这本书，鬼使神差的看到了这句话，所以来了兴趣，断断续续的看完了全书。

看完的当天晚上，我最后一次手淫，然后删除了所有的能让我再次走近网络色情的东西，一直搞到2026年3月22日凌晨3点。

为什么这么久？

因为作为一个患有仓鼠综合征的技术宅，过去二十年里，我的NAS逐步扩容，最终容纳了超过近80T的色情资源，删除这些东西，真的需要时间。还有浏览器的书签，telegram的channel和群组，B站和油管关注的频道，等等等等。

原版网站有英文，还有其他一些语言，但没有中文。我虽然可以英文阅读，但终究没有母语那么舒服，恰逢OpenClaw盛行，我想着用AI来帮助翻译，再看看中文版。

事实证明2026年3月的openclaw远不如各大厂开发的智能体，最终兜兜转转，我把这个译本放在GithubPages上托管，免费，开源。Copilot是好样的，它非常智能地解决了无数问题，并把这本书带到了这里，但中文的翻译还是很生涩。

解决办法就是，**能工智人**！

我也将本书的名字改为了《轻松褪色--帮你离开网络色情》，因为我不想那些恐惧戒色的看到标题就点了X，也想把目标锁定的更清晰--网络色情--，而不是所有的色情。具体原因，可以参见本书最后我作为译者夹带的“私货”，可以为你提供一些我总结的要点和思考。但不要提前看，虽然我没那么试过，但我本能的觉得，那样效果会大打折扣。

希望你对看到这里的你有所帮助，***切记，你可以打着手枪看到，但请按照顺序一点点读***！


（以下AI生成）
---

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
