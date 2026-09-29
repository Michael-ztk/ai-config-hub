# dsh 插件清单

## 已装（web profile）

| 包 | 版本 | 来源 | 作用 |
|---|---|---|---|
| `@deepseek-ai/dsh-base` | 0.1.7-rc.2 | 内置 | 基础层：sandbox / llm / credentials / commands |
| `@deepseek-ai/dsh-web-app` | 0.1.7-rc.2 | 内置 | Web UI 应用层 |
| `@changfenhuang/dsh-genui` | 0.9.8 | npm | GenUI：回复内联交互式 UI 组件 |
| `@linxin666/dsh-web-all` | 0.4.3 | npm | Web UI 全家桶聚合插件 |
| `@tt-a1i/archify-dsh` | 0.1.0 | npm | Archify 架构图技能（纯 skill bundle） |
| `@mars-sea/dsh-commandcode-provider` | 0.11.17 | npm | Command Code LLM provider |
| `dsh-codearts-auth` | 0.1.0 | git | CodeArts 登录 + 9 个 provider 路由 |

## 安装

npm 源：

```bash
dsh plugin --profile web add <包名>
```

git 源 —— **必须先放行 build 脚本**，否则 pnpm 拒跑 `prepare`，拿不到 `lib/`：

```yaml
# ~/.dsh/profiles/web/pnpm-workspace.yaml
allowBuilds:
  dsh-codearts-auth@git+https://gitee.com/iJetLi/deepseek-harness-codearts.git: true
```

```bash
dsh plugin --profile web add "https://gitee.com/iJetLi/deepseek-harness-codearts.git"
```

升级 git 源插件：重跑同一条 `add`。

> 源码目录安装用 `dsh plugin install <path>`，以 `link:` 安装，pnpm **不跑**
> `prepare`，必须先手动 `pnpm build:all`（不是 `build` —— 后者不产出
> `lib/client/jet-hub.js`）。

## `@linxin666/dsh-web-all` 子路由

共 26 个可选：`git-graph` `plugin-manager` `skill-explorer` `desktop-launcher`
`dsh-perf` `preset-center` `describe-image` `doctor` `liangshen` `market`
`model-capabilities` `pet` `remote-web-ui` `session-archive` `settings` `ssh`
`task-board` `usage` `skin-center` `update` `community-plugins` `shell`
`degraded` `client` `(main)`

**当前启用**：

| 子路由 | 作用 |
|---|---|
| `ssh` | SSH 主机管理 |
| `liangshen` | 良审 |
| `skill-explorer` | 技能浏览器 |
| `git-graph` | Git 图（`plugin: @linxin666/dsh-client-ui-git-graph`、`autoIsolate: true`） |

启用：往 profile 的 `cordis.patch.yml` 加

```yaml
- { id: web-ui-ssh, name: "@linxin666/dsh-web-all/ssh", disabled: false }
```

## 要点

- `dsh-codearts-auth` 声明了 `dsh.bundle.patch`，layer 栈自动拾取 `codearts-auth` 行，
  **不注册任何斜杠命令**，登录入口在 Jet Hub 设置页。
- `@mars-sea/dsh-commandcode-provider` 的 `visibleModels` 白名单改完保存即生效，
  不用重启。Go 档下 `xiaomi/mimo-v2.6-pro-ultraspeed` 不可用，别加。
