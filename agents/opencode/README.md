# opencode

> 配置：`~/.config/opencode/opencode.json`
> 当前模型：`cmd/deepseek/deepseek-v4.1-flash`

## 插件

- `oh-my-openagent`
- `disabled_providers`：`bp` / `bp2` / `xkiro`

## provider（7 个）

| provider | baseURL | 模型数 | 备注 |
|---|---|---|---|
| `sense-nova` | `token.sensenova.cn/v1` | 1 | 商汤，与 dsh 同源 |
| `sense` | 同上 | 4 | 同 baseURL 另一组模型 |
| `zhongzhuan` | `ai.hsnb.fun/v1` | 2 | 中转 |
| `huanjing` | 同上 | 2 | 同站另一组 |
| `cg` | `api.cgapi.top/v1` | 1 | |
| `cg1` | 同上 | 1 | 同站另一组 |
| `cmd` | `127.0.0.1:3050/v1` | 11 | 本地反代 |

完整模型列表见 [config-snapshot.yml](config-snapshot.yml)。

## 要点

1. 同一 baseURL 拆成多个 provider 是刻意的 —— 用来给不同模型组分组
   （如 `sense` / `sense-nova`、`cg` / `cg1`、`zhongzhuan` / `huanjing`）。
2. `cmd` 走本地反代，该服务没起时其下 11 个模型全部不可用。

## 项目级配置

`~/test_ws/.opencode/opencode.json` —— 工作区级覆盖。
