#!/usr/bin/env bash
# 在另一台机器（或重装 dsh 之后）恢复本机的插件配置。
#
# 用法：
#   bash restore.sh            # 恢复 web profile
#
# 前置：已安装 dsh，且 web profile 已初始化（dsh --profile web 至少跑过一次）。
# 凭据不随本仓库分发，恢复后需自行登录（Jet Hub 设置页）或填 ~/.dsh/.credentials.yaml。

set -uo pipefail

PROFILE="${1:-web}"
WS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE_DIR="${DSH_HOME:-$HOME/.dsh}/profiles/$PROFILE"

echo "profile = $PROFILE"
echo "目录     = $PROFILE_DIR"

if [ ! -d "$PROFILE_DIR" ]; then
    echo "错误：profile 目录不存在，先跑一次 dsh --profile $PROFILE 初始化" >&2
    exit 1
fi

# ---------- 1. git 源插件必须先放行 build 脚本 ----------
WS_FILE="$PROFILE_DIR/pnpm-workspace.yaml"
echo
echo "[1/4] 放行 dsh-codearts-auth 的 build 脚本"
touch "$WS_FILE"
if grep -q "dsh-codearts-auth" "$WS_FILE"; then
    echo "      已存在，跳过"
else
    python3 - "$WS_FILE" <<'PY'
import sys
p = sys.argv[1]
s = open(p).read()
key = "  dsh-codearts-auth@git+https://gitee.com/iJetLi/deepseek-harness-codearts.git: true"
lines = s.split("\n")
out, done = [], False
for l in lines:
    out.append(l)
    if l.startswith("allowBuilds:"):
        out.append(key); done = True
if not done:
    out += ["allowBuilds:", key]
open(p, "w").write("\n".join(out))
PY
    echo "      已写入 $WS_FILE"
fi

# ---------- 2. npm 插件 ----------
echo
echo "[2/4] 安装 npm 插件"
for pkg in \
    "@changfenhuang/dsh-genui" \
    "@linxin666/dsh-web-all" \
    "@tt-a1i/archify-dsh" \
    "@mars-sea/dsh-commandcode-provider"; do
    echo "      -> $pkg"
    dsh plugin --profile "$PROFILE" add "$pkg" || echo "      ⚠️ $pkg 安装失败，继续"
done

# ---------- 3. git 源插件 ----------
echo
echo "[3/4] 安装 git 源插件 dsh-codearts-auth"
dsh plugin --profile "$PROFILE" add \
    "https://gitee.com/iJetLi/deepseek-harness-codearts.git" \
    || echo "      ⚠️ 安装失败（检查 gitee 可达性与 allowBuilds 是否已生效）"

# ---------- 4. 配置文件 ----------
echo
echo "[4/4] 配置文件"
echo "      本仓库带了快照，按需手动合并（不要直接覆盖，先 diff）："
echo "        机器级: config-snapshot.yml   -> ~/.dsh/cordis.patch.yml"
echo "        profile: profile-web.patch.yml -> $PROFILE_DIR/cordis.patch.yml"
echo
echo "完成后重启 dsh 生效。"
