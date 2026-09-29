# DeepSeek Harness（dsh）

> 主力智能体。`dsh 0.1.7-rc.2` · `~/.nvm/versions/node/v24.14.0/bin/dsh`
> Web UI：`http://127.0.0.1:3080`

## 目录结构

| 路径 | 作用 |
|---|---|
| `~/.dsh/` | Harness Home（`DSH_HOME`） |
| `~/.dsh/settings.yaml` | 用户设置（当前为空，实际配置都写在补丁层） |
| `~/.dsh/cordis.patch.yml` | **机器级补丁层**，作用于每一个 profile |
| `~/.dsh/.credentials.yaml` | 凭据 refs；真值不进配置文件 |
| `~/.dsh/profiles/web/` | web profile（浏览器 UI，端口 3080） |
| `~/.dsh/profiles/headless/` | headless profile（无 UI，仅 base + headless） |
| `~/.agents/skills/` | 用户级技能 |

**补丁叠加顺序**：bundle 层 → profile 的 `cordis.patch.yml` → `--patch` 覆盖。
`~/.dsh/cordis.patch.yml` 是全局层，web / headless / tui 都吃，适合放「所有入口都要有的 provider」。

> ⚠️ 补丁是**整键替换**（不做深合并）。覆盖 config 时必须把该 config 的其它键一并重写。

## 插件（web profile）

| 包 | 版本 | 来源 |
|---|---|---|
| `@deepseek-ai/dsh-base` | 0.1.7-rc.2 | 内置 |
| `@deepseek-ai/dsh-web-app` | 0.1.7-rc.2 | 内置 |
| `@changfenhuang/dsh-genui` | 0.9.8 | npm |
| `@linxin666/dsh-web-all` | 0.4.3 | npm |
| `@tt-a1i/archify-dsh` | 0.1.0 | npm |
| `@mars-sea/dsh-commandcode-provider` | 0.11.17 | npm |
| `dsh-codearts-auth` | 0.1.0 | git（gitee） |

详情见 [plugins.md](plugins.md)、[providers.md](providers.md)。
配置快照：[config-snapshot.yml](config-snapshot.yml)（全局层）、
[profile-web.patch.yml](profile-web.patch.yml)（profile 层）。

## 常用命令

```bash
dsh --version
dsh --profile web --dump-config          # 导出合并后的完整配置（自检用）
dsh web --port 0 --no-open               # 起临时实例自检（不占 3080）
dsh plugin --profile web add <包名>       # 装插件
dsh plugin --profile web remove <包名>
bash ~/.dsh/profiles/web/restart-dsh.sh  # 重启（自动记录新 token）
```

> ⚠️ `dsh web` 子命令**不接受 `--profile`**，正确形式是 `dsh --profile web [选项]`。

## 已知坑（都真实踩过）

1. **npm 升级会打散 koffi 包的去重布局** —— 启动报
   `Duplicate type name 'DSH_STARTUPINFOW'`、插件树加载失败。根因是
   `dsh-win32-process` 等在模块顶层注册 koffi 类型，树里多份拷贝就会重复注册。
   修法：把 `dsh-win32-process` / `dsh-subprocess-local` / `dsh-sandbox-local` /
   `dsh-sandbox-windows-acl` 各收敛成 1 份。
2. **git 源插件必须先放行 build 脚本** —— pnpm 默认拒跑 `prepare`，拿不到 `lib/`，
   启动报 `ERR_MODULE_NOT_FOUND`。在 `pnpm-workspace.yaml` 的 `allowBuilds` 加条目。
3. **重启后 token 会变** —— 每次启动重新生成且不落 cookie，旧地址 401。用
   `restart-dsh.sh`，它会把新地址写到 `~/.dsh/logs/latest-web-url.txt`。
4. **`visibleModels` 白名单改完保存即生效**，不用重启；但
   `xiaomi/mimo-v2.6-pro-ultraspeed` 在 Go 档不可用，别加。

## 恢复

```bash
bash ../../scripts/restore-dsh.sh
```
