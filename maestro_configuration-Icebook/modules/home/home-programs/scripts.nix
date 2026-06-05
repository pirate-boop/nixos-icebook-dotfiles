{ ... }: {
  home.file.".local/bin/niri-focus-nth.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      N=$1
      OUTPUT=$(niri msg windows)

      CUR_WS=$(echo "$OUTPUT" | awk '
      /\(focused\)/ { found=1 }
      found && /Workspace ID:/ { print $3; exit }
      ')

      TARGET=$(echo "$OUTPUT" | awk -v ws="$CUR_WS" -v col="$N" '
      /^Window ID/ { id=$3; gsub(/:/,"",id) }
      /Workspace ID:/ { cur_ws=$3 }
      /Scrolling position:/ {
          c=$3; gsub(/,/,"",c)
          if (cur_ws == ws && c == col) print id
      }
      ' | head -1)

      [ -n "$TARGET" ] && niri msg action focus-window --id "$TARGET"
    '';
  };
}
