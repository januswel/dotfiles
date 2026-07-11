#!/bin/sh

input=$(cat)
echo "$input" > /tmp/statusline-input.json
MODEL=$(echo "$input" | jq -r '.model.id // .model.display_name')
CTX=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

H5=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
D7=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // 0' | cut -d. -f1)

# 5h 枠のリセットまでの残り時間
RESET=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // 0')
if [ "$RESET" -gt 0 ]; then
  REMAIN=$(( RESET - $(date +%s) ))
  LEFT=$(printf '%dh%02dm' $((REMAIN/3600)) $((REMAIN%3600/60)))
else
  LEFT="-"
fi

echo "[$MODEL] used ${CTX}% | 5h ${H5}% (reset ${LEFT}) / 7d ${D7}%"
