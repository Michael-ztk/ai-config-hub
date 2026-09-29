# Codex CLI

> 配置：`~/.codex/config.toml`
> 当前模型：`qwen/qwen3.8-max:free`，provider `xkiro`

## 主配置

```toml
model = "qwen/qwen3.8-max:free"
model_provider = "xkiro"
model_context_window = 1000000

[model_providers.xkiro]
name = "xKiro"
base_url = "https://api.xkiro.com/v1"
env_key = "XKIRO_API_KEY"
wire_api = "responses"
```

与 Claude Code 同一个中转、同一个模型。

## 受信任项目（trust_level = trusted）

- `/home/yjh/rk100_ws`
- `/home/yjh`
- `/home/yjh/rk100_ws/src/rk100-slam`
- `/home/yjh/.config/orca/rate-limit-pty-cwd`

## TUI

```toml
[tui.model_availability_nux]
"gpt-5.6-sol" = 4
```

## 其它文件

| 文件 | 说明 |
|---|---|
| `AGENTS.md` | 空 |
| `auth.json` | 凭据，不入库 |
| `hooks.json` | `pre_tool_use` / `permission_request` / `post_tool_use` / `session_start` / `user_prompt_submit` |
