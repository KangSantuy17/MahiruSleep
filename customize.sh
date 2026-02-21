while IFS= read -r line; do
  ui_print "$line"
done < "$MODPATH/woah.txt"
