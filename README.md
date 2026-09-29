# ai-config-hub

本机所有 AI 编码智能体的**插件 / 技能 / 模型**清单。已脱敏，不含密钥。

## 总览

| 智能体 | 配置位置 | 当前模型 |
|---|---|---|
| **dsh** | `~/.dsh/` | `commandcode` / `deepseek-v4.1-flash` |
| **opencode** | `~/.config/opencode/opencode.json` | `cmd/deepseek/deepseek-v4.1-flash` |
| **claude** | `~/.claude/settings.json` | `qwen/qwen3.8-max:free` |
| **codex** | `~/.codex/config.toml` | `qwen/qwen3.8-max:free` |
| **gemini** | `~/.gemini/` | — |
| **cursor** | `~/.cursor/` | — |

## 目录

```
agents/dsh/       插件、provider、配置快照
agents/opencode/  7 个 provider 快照
agents/claude/    env + hooks
agents/codex/     config.toml
agents/gemini/    记忆
agents/cursor/    agent 定义
skills/           跨智能体技能清单 + 待装清单
scripts/          restore-dsh.sh / redact-check.sh
```

## 恢复

```bash
bash scripts/restore-dsh.sh        # 重装 dsh 全部插件
bash scripts/redact-check.sh       # 提交前密钥自查（应保持 ✓）
```

各智能体的凭据**不入库**，恢复后需自行登录或填各自的凭据文件。

## 共享资源（改一处别忘了另一处）

- `commandcode` 与 `sense-nova`：dsh、opencode 都接了
- claude 与 codex：都走 xkiro 中转 `api.xkiro.com`
