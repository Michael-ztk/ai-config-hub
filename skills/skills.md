# 技能清单

## 已装

| 技能 | 归属 | 位置 |
|---|---|---|
| `caveman` | dsh 用户级 | `~/.agents/skills/caveman/` |
| `find-skills` | dsh 用户级 | `~/.agents/skills/find-skills/` |
| `archify` | dsh bundle | 随 `@tt-a1i/archify-dsh` |
| `genui` | dsh bundle | 随 `@changfenhuang/dsh-genui` |
| `skill-creator` | Claude | `~/.claude/skills/skill-creator/` |

安装：

```bash
npx skills add <owner/repo@skill> -g -y
```

浏览：dsh 的 `@linxin666/dsh-web-all/skill-explorer` 子路由已启用，Web UI 里可直接看。

## 待装：公众号写作

本机没有公众号相关技能。生态里现成的（按安装量）：

| 技能 | 安装量 | 用途 |
|---|---|---|
| `jimliu/baoyu-skills@baoyu-post-to-wechat` | 34K | 发布到公众号 |
| `jimliu/baoyu-skills@baoyu-markdown-to-html` | 31.8K | Markdown → 公众号 HTML |
| `dontbesilent2025/dbskill@dbs-wechat-html` | 14.4K | 公众号 HTML 排版 |
| `iamzhihuix/happy-claude-skills@wechat-article-writer` | 3.3K | 选题→撰写→标题→排版 全流程 |

```bash
npx skills add iamzhihuix/happy-claude-skills --skill wechat-article-writer -g -y
```

⚠️ 两个坑：

1. `wechat-article-writer` 第一步要读 `CLAUDE.md` 取写作风格，本机该文件不存在，
   装完需改成 `AGENTS.md` 或内联风格要求。
2. `baoyu-*` 只管「后半段」（排版 / 发布），不管选题行文。要全流程就
   `wechat-article-writer` + `baoyu-markdown-to-html` 组合。
