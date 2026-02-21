#!/system/bin/sh
module=${0%/*}

if [ -d "$module/system/bin" ]; then
  for command in "$module/system/bin"/*; do
    [ -e "$command" ] || continue
    rm -f "/data/adb/ksu/bin/$(basename "$command")"
  done
fi
