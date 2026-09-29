# 插件清单（web profile）

来源：`~/.dsh/profiles/web/package.json` 的 `dsh.profile.bundles`

| 包 | 版本 | 来源 | 作用 |
|---|---|---|---|
| `@deepseek-ai/dsh-base` | 0.1.7-rc.2 | 内置 | 基础层：sandbox / llm / credentials / commands 等服务 |
| `@deepseek-ai/dsh-web-app` | 0.1.7-rc.2 | 内置 | Web UI 应用层 |
| `@changfenhuang/dsh-genui` | 0.9.8 | npm | GenUI：回复内联渲染的交互式 UI 组件 |
| `@linxin666/dsh-web-all` | 0.4.3 | npm | Web UI 全家桶聚合插件 |
| `@tt-a1i/archify-dsh` | 0.1.0 | npm | Archify 架构图技能（skill-only bundle） |
| `@mars-sea/dsh-commandcode-provider` | 0.11.17 | npm | Command Code LLM provider 路由 |
| `dsh-codearts-auth` | 0.1.0 | git | CodeArts 登录 + 多 provider 路由 |

## 安装命令

npm 源：

```bash
dsh plugin --profile web add <包名>
```

git 源（`dsh-codearts-auth`）—— **必须先放行 build 脚本**，否则 pnpm 拒跑 `prepare`，
拿不到 `lib/` 产物：

```yaml
# ~/.dsh/profiles/web/pnpm-workspace.yaml
allowBuilds:
  dsh-codearts-auth@git+https://gitee.com/iJetLi/deepseek-harness-codearts.git: true
```

```bash
dsh plugin --profile web add "https://gitee.com/iJetLi/deepseek-harness-codearts.git"
```

`add` 以 `git+https` 安装，pnpm 会跑 `prepare`（= `tsc` + `copy-assets` + `build:client`）。
升级时**重跑同一条 `add`** 即可拉取最新并重建。

> 另一种「源码目录安装」用 `dsh plugin install <path>`，以 `link:` 安装，
> pnpm **不会**为 `link:` 依赖跑 `prepare`，必须先手动 `pnpm build:all`。
> 且必须是 `build:all` 而非 `build` —— 后者不产出 `lib/client/jet-hub.js`。

## `@linxin666/dsh-web-all` 子路由（26 个）

全部可选：`(main)`、`client`、`shell`、`degraded`、`community-plugins`、`git-graph`、
`plugin-manager`、`skill-explorer`、`desktop-launcher`、`dsh-perf`、`preset-center`、
`describe-image`、`doctor`、`liangshen`、`market`、`model-capabilities`、`pet`、
`remote-web-ui`、`session-archive`、`settings`、`ssh`、`task-board`、`usage`、
`skin-center`、`update`。

**当前已启用**（`disabled: false`）：

| 子路由 | 作用 |
|---|---|
| `ssh` | SSH 主机管理 |
| `liangshen` | 良审 |
| `skill-explorer` | 技能浏览器 |
| `git-graph` | Git 图（配置 `plugin: @linxin666/dsh-client-ui-git-graph`、`autoIsolate: true`） |

启用方式（写进 profile 的 `cordis.patch.yml`）：

```yaml
- { id: web-ui-ssh, name: "@linxin666/dsh-web-all/ssh", disabled: false }
```

## 其它插件要点

- **`@mars-sea/dsh-commandcode-provider`**：注册 `commandcode` 路由，直连 Command Code
  API 并带实时模型目录。`visibleModels` 白名单在 profile 补丁里控制可见模型。
- **`@tt-a1i/archify-dsh`**：只导出 `.` 和 `./package.json`，是纯技能包，不提供 UI。
- **`dsh-codearts-auth`**：声明 `dsh.bundle.patch`（`cordis.patch.yml`），profile 的
  layer 栈会自动拾取 `codearts-auth` 行，**不注册任何斜杠命令**，登录入口在 Jet Hub 设置页。
