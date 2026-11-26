# DeepSeek Harness（dsh）

`dsh 0.2.2-rc.5` · Web UI `http://127.0.0.1:3080`

## 插件（web profile）

| 包 | 版本 | 来源 |
|---|---|---|
| `@deepseek-ai/dsh-base` | 0.2.2-rc.5 | 内置 |
| `@deepseek-ai/dsh-web-app` | 0.2.2-rc.5 | 内置 |
| `@changfenhuang/dsh-genui` | 0.15.0 | npm |
| `@linxin666/dsh-web-all` | 0.4.15 | npm |
| `@tt-a1i/archify-dsh` | 1.0.0 | npm |
| `@mars-sea/dsh-commandcode-provider` | 0.17.2 | npm |
| `dsh-providers-hub` | 0.2.1-rc.5 | git（gitee） |

详见 [plugins.md](plugins.md)。

## 安装 / 升级

```bash
# npm 源
dsh plugin --profile web add <包名>

# git 源（需先放行 build 脚本，见 plugins.md）
dsh plugin --profile web add "https://gitee.com/iJetLi/deepseek-harness-codearts.git"
```

一键恢复全部：`bash ../../scripts/restore-dsh.sh`

## provider

- 默认：`commandcode` / `deepseek/deepseek-v4.1-flash`
- 全局层：`sense-nova`（商汤）
- `dsh-providers-hub` 带来 9 个：`codearts` `qoder` `qodercn` `trae` `cline`
  `loomy` `lobsterai` `buddy` `workbuddy` `raccoon`

详见 [providers.md](providers.md)。

## 配置快照

- [config-snapshot.yml](config-snapshot.yml) —— 全局层 `~/.dsh/cordis.patch.yml`
- [profile-web.patch.yml](profile-web.patch.yml) —— `~/.dsh/profiles/web/cordis.patch.yml`

> 补丁是**整键替换**（不深合并），覆盖 config 时必须把其它键一并重写。

## 常用命令

```bash
dsh --profile web --dump-config        # 导出合并后配置
dsh web --port 0 --no-open             # 起临时实例自检
dsh plugin --profile web add/remove <包名>
bash ~/.dsh/profiles/web/restart-dsh.sh
```

> `dsh web` 子命令不接受 `--profile`，要用 `dsh --profile web [选项]`。
