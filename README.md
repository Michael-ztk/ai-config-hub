# DSH 配置速查（本机存档）

> 生成于 2026-09-29 · 仅记录**结构与非敏感配置**，不含任何密钥 / token。
> 环境：`dsh 0.1.7-rc.2` · `node v24.14.0` · 全局安装
> `~/.nvm/versions/node/v24.14.0/lib/node_modules/@deepseek-ai/dsh`

## 目录结构

| 路径 | 作用 |
|---|---|
| `~/.dsh/` | Harness Home（`DSH_HOME`） |
| `~/.dsh/settings.yaml` | 用户设置（当前为空，实际配置都写在补丁层） |
| `~/.dsh/cordis.patch.yml` | **机器级补丁层**，作用于每一个 profile |
| `~/.dsh/.credentials.yaml` | 凭据 refs；真值不进配置文件 |
| `~/.dsh/profiles/web/` | web profile（浏览器 UI，端口 3080） |
| `~/.dsh/profiles/headless/` | headless profile（无 UI） |
| `~/.agents/skills/` | 用户级技能 |

**补丁叠加顺序**：bundle 层 → profile 的 `cordis.patch.yml` → `--patch` 覆盖。
`~/.dsh/cordis.patch.yml` 是全局层，web / headless / tui 都会吃到，适合放「所有入口都要有的 provider」。

> 语义提醒：补丁是**整键替换**（不做深合并），所以覆盖 config 时必须把该 config
> 的其它键一并重写，否则会被抹掉。

## 插件速览（web profile）

| 包 | 版本 | 来源 |
|---|---|---|
| `@deepseek-ai/dsh-base` | 0.1.7-rc.2 | 内置 |
| `@deepseek-ai/dsh-web-app` | 0.1.7-rc.2 | 内置 |
| `@changfenhuang/dsh-genui` | 0.9.8 | npm |
| `@linxin666/dsh-web-all` | 0.4.3 | npm |
| `@tt-a1i/archify-dsh` | 0.1.0 | npm |
| `@mars-sea/dsh-commandcode-provider` | 0.11.17 | npm |
| `dsh-codearts-auth` | 0.1.0 | git（gitee） |

详见 [plugins.md](plugins.md)。

## LLM provider 路由

- 默认：`commandcode` / `deepseek/deepseek-v4.1-flash`
- 全局层另有 `sense-nova` 路由（商汤）
- `dsh-codearts-auth` 带来 `codearts` + `qoder` / `qodercn` / `trae` / `cline` /
  `loomy` / `lobsterai` / `buddy` / `workbuddy` / `raccoon`

详见 [providers.md](providers.md)。

## 技能

用户级 2 个（`caveman`、`find-skills`）+ 一个 bundle 自带的 `archify`。
详见 [skills.md](skills.md)。

## 恢复

```bash
bash restore.sh          # 重装全部插件（详见文件内注释）
```

## 已知坑（都真实踩过）

1. **`dsh web` 子命令不接受 `--profile`** —— 正确形式是 `dsh --profile web [选项]`。
2. **npm 升级会打散 koffi 包的去重布局** —— 表现是启动报
   `Duplicate type name 'DSH_STARTUPINFOW'`、插件树加载失败。根因是
   `dsh-win32-process` 等在模块顶层注册 koffi 类型，树里若有多份拷贝就会重复注册。
   修法：把 `dsh-win32-process` / `dsh-subprocess-local` / `dsh-sandbox-local` /
   `dsh-sandbox-windows-acl` 各收敛成 1 份。
3. **git 源插件必须先放行 build 脚本** —— pnpm 默认拒跑 `prepare`，
   否则拿不到 `lib/` 产物，启动报 `ERR_MODULE_NOT_FOUND`。
4. **重启后 token 会变** —— 每次启动重新生成且不落 cookie，旧地址 401。
   用 `restart-dsh.sh`（在 web profile 目录）会自动把新地址写到
   `~/.dsh/logs/latest-web-url.txt`。
