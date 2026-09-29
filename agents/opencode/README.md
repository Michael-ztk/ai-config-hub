# opencode

> 配置：`~/.config/opencode/opencode.json`（5.4 KB，有 4 个 `.bak` 备份）
> 当前模型：`cmd/deepseek/deepseek-v4.1-flash`

## 结构

```json
{ "$schema": "...", "provider": {...}, "plugin": [...], "disabled_providers": [...], "model": "..." }
```

- **plugin**：装了 `oh-my-openagent`
- **disabled_providers**：`bp` / `bp2` / `xkiro`

## provider（7 个，多为中转站）

| provider | baseURL | 模型数 | 备注 |
|---|---|---|---|
| `sense-nova` | `token.sensenova.cn/v1` | 1 | 商汤，与 dsh 同源 |
| `sense` | 同上 | 4 | 同 baseURL 另一组模型 |
| `zhongzhuan` | `ai.hsnb.fun/v1` | 2 | 中转 |
| `huanjing` | 同上 | 2 | 同站另一组 |
| `cg` | `api.cgapi.top/v1` | 1 | |
| `cg1` | 同上 | 1 | 同站另一组 |
| `cmd` | `127.0.0.1:3050/v1` | 11 | ⚠️ 本地反代 |

完整模型列表见 [config-snapshot.yml](config-snapshot.yml)。

## 要点

1. **`cmd` 指向本地反代 `127.0.0.1:3050/v1`** —— dsh 侧曾有同样配置，因与
   `commandcode` 插件抢路由 id 已移除；opencode 这边还在用。
   若该反代没起，`cmd` 下的模型全部不可用。
2. **同一 baseURL 拆成多个 provider 是刻意的** —— 用来给不同模型组分组
   （如 `sense` / `sense-nova`、`cg` / `cg1`、`zhongzhuan` / `huanjing`）。
3. 配置文件旁有 `.bak` / `.bak-20260916` / `.bak-20260923` / `.bak-20260923-sub2api`
   四个备份，改坏了可回退。

## 项目级配置

`~/test_ws/.opencode/opencode.json` —— 工作区级覆盖（80 字节，很简）。
