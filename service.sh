#!/system/bin/sh
module=${0%/*}

if [ ! -f "$module/setup" ]; then
  # chmod the scripts
  chmod 744 "$module/scripts"/*

  if [ -d "$module/system/bin" ]; then
    # adding the custom command
    chmod 744 "$module/system/bin"/*
    for command in "$module/system/bin"/*; do
      [ -e "$command" ] || continue
      ln -sf "$command" "/data/adb/ksu/bin/$(basename "$command")"
    done
  fi

  # mark it complete
  touch "$module/setup"
fi

# running all the scripts
for command in "$module"/scripts/*; do
  "$command" &
done
