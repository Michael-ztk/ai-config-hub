# ai-config-hub

本机**所有 AI 编码智能体**的配置档案库（已脱敏，不含任何密钥 / token）。

> 建立于 2026-09-29 · 环境 `node v24.14.0` · Linux
> 用途：换机 / 重装后按图索骥恢复；也作为「哪个智能体接了哪个模型」的单一事实来源。

## 目录

```
agents/
  dsh/        DeepSeek Harness（主力，Web UI 端口 3080）
  opencode/   opencode（多 provider 中转，配置最杂）
  claude/     Claude Code
  codex/      Codex CLI
  gemini/     Gemini CLI
  cursor/     Cursor
skills/       跨智能体技能清单
scripts/      恢复脚本
```

## 一句话现状

| 智能体 | 配置位置 | 当前主力模型 | 特点 |
|---|---|---|---|
| **dsh** | `~/.dsh/` | `commandcode` / `deepseek-v4.1-flash` | 插件体系最完整，9+ provider |
| **opencode** | `~/.config/opencode/opencode.json` | `cmd/deepseek/deepseek-v4.1-flash` | 7 个 provider，多为中转站 |
| **claude** | `~/.claude/settings.json` | `qwen/qwen3.8-max:free` | 走 xkiro 中转，全档位同一模型 |
| **codex** | `~/.codex/config.toml` | `qwen/qwen3.8-max:free` | 同样走 xkiro |
| **gemini** | `~/.gemini/GEMINI.md` | — | 仅存一条记忆：用中文交流 |
| **cursor** | `~/.cursor/` | — | 有 `agents/` 目录 |

## 关键结论

1. **`commandcode` 与 `sense-nova` 是共享的** —— dsh 和 opencode 都接了商汤
   `token.sensenova.cn`。改一处别忘了另一处。
2. **opencode 的 `cmd` provider 指向本地反代 `127.0.0.1:3050/v1`** —— dsh 侧曾
   有同样配置，因与 `commandcode` 插件抢路由 id 已移除。opencode 那边还在用。
3. **claude / codex 都走 xkiro 中转**（`api.xkiro.com`），且 claude 把
   sonnet/haiku/opus **全部指向同一个** `qwen3.8-max:free`。
4. **opencode 装了 `oh-my-openagent` 插件**，并显式禁用了 `bp` / `bp2` / `xkiro`
   三个 provider。

## 凭据

**本仓库不含任何密钥。** 所有 API Key 都在各自的凭据文件里：

- dsh → `~/.dsh/.credentials.yaml`（配置只写 `apiKeyEnv` 引用）
- claude → `~/.claude/settings.json` 的 `env.ANTHROPIC_AUTH_TOKEN`
- codex → `~/.codex/auth.json`
- git → `~/.git-credentials`（`credential.helper = store`）

恢复配置后需**自行填密钥**，或走各智能体自己的登录流程。

## 安全

提交前请自查：

```bash
grep -rniE "sk-[A-Za-z0-9]{10,}|AKID|Bearer [A-Za-z0-9]{20,}|token=[A-Za-z0-9_-]{20,}" .
```

`scripts/redact-check.sh` 封装了这一步。
