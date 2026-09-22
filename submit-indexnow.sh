#!/bin/bash
# IndexNow 推送脚本 —— 用于主动通知 Bing / Yandex / Seznam 抓取更新的页面
#
# 用法:
#   ./submit-indexnow.sh                          # 推送全部已收录页面
#   ./submit-indexnow.sh <url1> <url2> ...        # 推送指定 URL
#
# 注意: 本站点托管在 GitHub Pages 子路径下, 域名根(https://mqbit.github.io/)返回 404,
#       因此 IndexNow 默认去 /{key}.txt 查找密钥必然失败。必须在 payload 中显式声明
#       keyLocation, 否则接口会返回 200/202 但实际静默拒绝。
#       本脚本已内置该字段。

set -euo pipefail

SITE_BASE="https://mqbit.github.io/VitalBPDiary-Support"
KEY="10d405bfabaafb8babc98bce42759b3b"
KEY_LOCATION="${SITE_BASE}/${KEY}.txt"
ENDPOINT="https://www.bing.com/indexnow"   # 用 bing 端点: 它会返回真实错误码(403), api.indexnow.org 只会返回 202

if [ $# -gt 0 ]; then
  URLS=("$@")
else
  URLS=(
    "${SITE_BASE}/"
    "${SITE_BASE}/diet-food-traffic-light.html"
    "${SITE_BASE}/blood-pressure-classification.html"
    "${SITE_BASE}/home-bp-measurement.html"
  )
fi

# 用 node 构造 JSON, 避免手写转义出错
PAYLOAD=$(KEY="$KEY" KEY_LOCATION="$KEY_LOCATION" /Users/qiuchunwei/.workbuddy/binaries/node/versions/22.22.2-3/bin/node -e '
const key = process.env.KEY;
const keyLocation = process.env.KEY_LOCATION;
const urls = process.argv.slice(1);
process.stdout.write(JSON.stringify({ host: "mqbit.github.io", key, keyLocation, urlList: urls }));
' "${URLS[@]}")

echo "推送端点: ${ENDPOINT}"
echo "密钥位置: ${KEY_LOCATION}"
echo "URL 数量: ${#URLS[@]}"
echo "---"

# 同时打印 HTTP 码与响应体: 只看状态码会被假成功骗过
RESP=$(curl -s -w '\n%{http_code}' -X POST "$ENDPOINT" \
  -H 'Content-Type: application/json; charset=utf-8' \
  --data-binary "$PAYLOAD")

HTTP_CODE=$(echo "$RESP" | tail -n1)
BODY=$(echo "$RESP" | sed '$d')

echo "HTTP 状态码: ${HTTP_CODE}"
echo "响应体: ${BODY:-(空)}"

if [ "$HTTP_CODE" = "200" ] && [ -z "$BODY" ]; then
  echo "✅ 推送成功 (200 空响应体 = 已被接受)"
elif [ -n "$BODY" ]; then
  echo "❌ 被拒绝: ${BODY}"
  exit 1
else
  echo "⚠️  状态码 ${HTTP_CODE}, 请人工确认"
  exit 1
fi
