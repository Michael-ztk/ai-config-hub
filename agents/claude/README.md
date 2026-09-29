# Claude Code

> 配置：`~/.claude/settings.json`
> 当前模型：`qwen/qwen3.8-max:free`（走 xkiro 中转）

## 模型

```json
{
  "ANTHROPIC_BASE_URL": "https://api.xkiro.com",
  "ANTHROPIC_AUTH_TOKEN": "<redacted>",
  "ANTHROPIC_MODEL": "qwen/qwen3.8-max:free",
  "ANTHROPIC_DEFAULT_SONNET_MODEL": "qwen/qwen3.8-max:free",
  "ANTHROPIC_DEFAULT_HAIKU_MODEL": "qwen/qwen3.8-max:free",
  "ANTHROPIC_DEFAULT_OPUS_MODEL": "qwen/qwen3.8-max:free"
}
```

四个档位（sonnet / haiku / opus / 默认）全部指向同一个模型 —— 按档位切模型无效。

## hooks（11 个）

`SessionStart` / `UserPromptSubmit` / `Stop` / `StopFailure` / `SubagentStart` /
`SubagentStop` / `TeammateIdle` / `PreToolUse` / `PostToolUse` /
`PostToolUseFailure` / `PermissionRequest`

其余字段：`theme`、`statusLine`、`effortLevel`。

## 技能

`~/.claude/skills/` 下只有 `skill-creator`。

无 `CLAUDE.md`。
