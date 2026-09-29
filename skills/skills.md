# 技能清单（跨智能体）

## 总览

| 技能 | 归属 | 位置 |
|---|---|---|
| `caveman` | dsh（用户级） | `~/.agents/skills/caveman/` |
| `find-skills` | dsh（用户级） | `~/.agents/skills/find-skills/` |
| `archify` | dsh bundle | 随 `@tt-a1i/archify-dsh` |
| `genui` | dsh bundle | 随 `@changfenhuang/dsh-genui` |
| `skill-creator` | Claude | `~/.claude/skills/skill-creator/` |

## dsh 用户级技能

| 技能 | 说明 |
|---|---|
| `caveman` | 极限压缩表达，省 token（lite / full / ultra / wenyan 多档） |
| `find-skills` | 从 skills.sh 生态搜索并安装技能 |

```bash
npx skills add <owner/repo@skill> -g -y
```

浏览器：`@linxin666/dsh-web-all/skill-explorer` 已启用，可在 Web UI 里直接浏览已装技能。

## 待办：公众号写作技能

本机**没有**公众号相关技能。生态里现成的（按安装量）：

| 技能 | 安装量 | 用途 |
|---|---|---|
| `jimliu/baoyu-skills@baoyu-post-to-wechat` | 34K | 发布到公众号 |
| `jimliu/baoyu-skills@baoyu-markdown-to-html` | 31.8K | Markdown → 公众号 HTML |
| `dontbesilent2025/dbskill@dbs-wechat-html` | 14.4K | 公众号 HTML 排版 |
| `iamzhihuix/happy-claude-skills@wechat-article-writer` | 3.3K | 选题→撰写→标题→排版 全流程 |

```bash
npx skills add iamzhihuix/happy-claude-skills --skill wechat-article-writer -g -y
```

⚠️ **两个坑**：

1. `wechat-article-writer` 的 SKILL.md 第一步要求读取用户的 `CLAUDE.md` 获取写作风格。
   本机 `~/.claude/CLAUDE.md` **不存在**（`~/.codex/AGENTS.md` 也是 0 字节），
   装完需改成 `AGENTS.md` 或内联风格要求，否则那步空转。
2. `baoyu-*` 系列解决的是「后半段」（排版 / 发布），不解决选题和行文。
   要全流程就 `wechat-article-writer` + `baoyu-markdown-to-html` 组合。
