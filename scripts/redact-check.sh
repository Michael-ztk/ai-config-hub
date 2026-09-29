#!/usr/bin/env bash
# 提交前自查：确认没有密钥 / token 混进仓库。
#
# 用法：bash scripts/redact-check.sh
# 退出码 0 = 干净；1 = 发现疑似密钥（会打印文件名与行号，但不打印内容）。

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PATTERN='sk-[A-Za-z0-9]{16,}|AKID[A-Za-z0-9]{8,}|Bearer [A-Za-z0-9_-]{20,}|token=[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|-----BEGIN [A-Z ]*PRIVATE KEY-----'

echo "扫描目录: $ROOT"
echo

HITS="$(grep -rnE "$PATTERN" . 2>/dev/null | grep -v '^\./\.git/' || true)"

if [ -z "$HITS" ]; then
    echo "✓ 干净：未发现疑似密钥 / token"
    exit 0
fi

echo "✗ 发现疑似密钥（只列位置，不打印内容）："
echo "$HITS" | while IFS= read -r line; do
    echo "  ${line%%:*}  第 $(echo "$line" | cut -d: -f2) 行"
done
echo
echo "处理建议："
echo "  1. 把真值挪到 ~/.dsh/.credentials.yaml 或环境变量，配置里只写 {env:VAR} 引用"
echo "  2. 若已提交过，需 git filter-repo 清理历史并强制轮换该密钥"
exit 1
