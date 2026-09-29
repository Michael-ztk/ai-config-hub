# LLM provider 路由

## 默认模型

`~/.dsh/cordis.patch.yml`：

```yaml
- id: agent-default-model
  name: '@deepseek-ai/dsh-agent-default-model'
  config:
    provider: commandcode
    model: deepseek/deepseek-v4.1-flash
```

## `commandcode`

由 `@mars-sea/dsh-commandcode-provider@0.11.17` 提供，直连 Command Code API。

`~/.dsh/profiles/web/cordis.patch.yml` 里的可见模型白名单：

```yaml
- id: llm-commandcode
  name: "@mars-sea/dsh-commandcode-provider"
  config:
    apiKeyEnv: COMMANDCODE_API_KEY
    visibleModels:
      - deepseek/deepseek-v4.1-flash
      - z-ai/glm-5.3-flash
      - xiaomi/mimo-v2.6-flash
      - xiaomi/mimo-v2.6-pro
```

> 白名单改动**保存即生效**，不用重启。
> 注意 `xiaomi/mimo-v2.6-pro-ultraspeed` 在 Go 档不可用，别加。

## `sense-nova`

在全局层 `~/.dsh/cordis.patch.yml`，用 `@deepseek-ai/dsh-llm-pi-ai` 声明：

```yaml
- id: llm-pi-ai
  name: '@deepseek-ai/dsh-llm-pi-ai'
  config:
    providers:
      sense-nova:
        displayName: Sense Nova
        apiKeyEnv: SENSENOVA_API_KEY
        api: openai-completions
        baseURL: https://token.sensenova.cn/v1
        defaultContextWindow: 262144
        defaultMaxTokens: 32000
        models:
          - id: glm-5.2
          - id: deepseek-v4-pro
          - id: deepseek-v4-flash
          - id: kimi-k3
          - id: sensenova-6.8-flash-lite
```

密钥**不进配置**，只写 `apiKeyEnv` 引用；真值放 `~/.dsh/.credentials.yaml`。
解析顺序：进程环境 > 该文件 > `.env`。

> 历史：这里原先手声明 `commandcode` 路由指向本地反代 `127.0.0.1:3050/v1`，
> 与插件抢同一个路由 id，已整块移除。回退可换回
> `~/.dsh/cordis.patch.yml.bak-20260917`。

## `dsh-codearts-auth` 带来的路由

共 9 个 provider，**登录入口统一在 Jet Hub 设置页**，不注册斜杠命令：

| 路由 | 服务 | 备注 |
|---|---|---|
| `codearts` | 华为云 CodeArts | `SDK-HMAC-SHA256` 签名；带积分账户检测与每日签到 |
| `qoder` | 阿里 Qoder 国际版 | 加密推理端点，含 Qwen3.8 系列 |
| `qodercn` | Qoder 中国版 | 同上协议，14 模型 |
| `trae` | 字节 TRAE | SOLO 通道，请求响应都需转换 |
| `cline` | Cline | WorkOS 设备码；免费模型标 `· 免费` |
| `loomy` | 讯飞 Loomy | 唯一短信登录；**唯一不能自动续期** |
| `lobsterai` | 有道龙虾 | 本地回调服务器收 authCode |
| `buddy` | 腾讯 CodeBuddy | 支持锁定永久积分 |
| `workbuddy` | WorkBuddy 国际版 | 支持锁定永久积分 |

登录后在对话框模型选择器里出现；每个 provider 都有「显示列表」可逐个开关模型（黑名单制）。
