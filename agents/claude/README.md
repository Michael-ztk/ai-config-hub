# Claude Code

> 配置：`~/.claude/settings.json`（6.2 KB）
> 当前模型：`qwen/qwen3.8-max:free`（走 xkiro 中转）

## env

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

⚠️ **四个档位（sonnet / haiku / opus / 默认）全部指向同一个模型**
`qwen3.8-max:free` —— 所以按档位切模型是没有效果的，切模型只有一个实际选项。

## hooks（11 个事件）

`SessionStart` / `UserPromptSubmit` / `Stop` / `StopFailure` / `SubagentStart` /
`SubagentStop` / `TeammateIdle` / `PreToolUse` / `PostToolUse` /
`PostToolUseFailure` / `PermissionRequest`

其余字段：`theme`、`statusLine`、`effortLevel`。

## 技能

`~/.claude/skills/` 下只有 `skill-creator`。

## 其它

- `~/.claude/backups/` 有备份；`settings.json.bak` 在同级
- `history.jsonl`、`projects/`、`sessions/`、`transcripts/` 是运行数据，**不入库**
- 无 `CLAUDE.md`（这点会让某些第三方 skill 的写作风格步骤失效，见 skills/）

## 配置文件附带的坑

`settings.json` 里 `env` 是直写的 inline token（不是 `{env:VAR}` 引用），
所以**这个文件绝对不能提交进仓库**。本目录只记录结构。
