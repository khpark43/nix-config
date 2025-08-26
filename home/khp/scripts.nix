{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "list-keybinds" ''
      # check if rofi is already running
      if pidof rofi > /dev/null; then
        pkill rofi
      fi
      msg='     KEYMAPS'
      keybinds=$(cat ~/.config/hypr/hyprland.conf | grep -E '^bind')
      display_keybinds=$(echo "$keybinds" | sed 's/\$mod/SUPER/g')
      # display_keybinds=$(echo "$keybinds" | sed -e 's/\$mod/SUPER/g' -e 's/^[[:space:]]*//')
      echo "$display_keybinds" | rofi -x11 -dmenu -i -config ~/.config/rofi/config-long.rasi -mesg "$msg"
    '')
    (pkgs.writeShellScriptBin "screenshootin" ''
      grim -g "$(slurp)" - | swappy -f -
    '')
    (pkgs.writeShellScriptBin "rofi-launcher" ''
      # check if rofi is already running
      if pidof rofi > /dev/null; then
        pkill rofi
      fi
      rofi -x11 -show drun # no input method support on wayland yet
    '')
    (pkgs.writeShellScriptBin "emopicker9000" ''
      # check if rofi is already running
      if pidof rofi > /dev/null; then
        pkill rofi
      fi

      # Get user selection via rofi from emoji file.
      chosen=$(cat $HOME/.config/.emoji | ${pkgs.rofi-wayland}/bin/rofi -i -dmenu -config ~/.config/rofi/config-long.rasi | awk '{print $1}')

      # Exit if none chosen.
      [ -z "$chosen" ] && exit

      # If you run this command with an argument, it will automatically insert the
      # character. Otherwise, show a message that the emoji has been copied.
      if [ -n "$1" ]; then
      ${pkgs.ydotool}/bin/ydotool type "$chosen"
      else
          printf "$chosen" | ${pkgs.wl-clipboard}/bin/wl-copy
      ${pkgs.libnotify}/bin/notify-send "'$chosen' copied to clipboard." &
      fi
    '')
    (pkgs.writeShellScriptBin "web-search" ''
      # check if rofi is already running
      if pidof rofi > /dev/null; then
        pkill rofi
      fi

      declare -A URLS

      URLS=(
        ["🌎 Search"]="https://www.google.com/search?q="
        ["❄️ Unstable Packages"]="https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query="
        ["🎞️ YouTube"]="https://www.youtube.com/results?search_query="
        ["🦥 Arch Wiki"]="https://wiki.archlinux.org/title/"
        ["🐃 Gentoo Wiki"]="https://wiki.gentoo.org/index.php?title="
      )
      ORDER=("🌎 Search" "❄️ Unstable Packages" "🎞️ YouTube" "🦥 Arch Wiki" "🐃 Gentoo Wiki")
    
      # List for rofi
      gen_list() {
        for i in "''${ORDER[@]}"; do
          echo "$i"
        done
      }

      main() {
        # Pass the list to rofi
        platform=$( (gen_list) | ${pkgs.rofi-wayland}/bin/rofi -x11 -dmenu -config ~/.config/rofi/config-long.rasi )

        if [[ -n "$platform" ]]; then
          query=$( (echo ) | ${pkgs.rofi-wayland}/bin/rofi -x11 -dmenu -config ~/.config/rofi/config-long.rasi )

          if [[ -n "$query" ]]; then
            url=''${URLS[$platform]}$query
            xdg-open "$url"
          else
            exit
          fi
        else
          exit
        fi
      }

      main

      exit 0
    '')
    (pkgs.writeShellScriptBin "wallsetter" ''
      TIMEOUT=720

      for pid in $(pidof -o %PPID -x wallsetter); do
        kill $pid
      done

      if ! [ -d ~/Pictures/Wallpapers ]; then notify-send -t 5000 "~/Pictures/Wallpapers does not exist" && exit 1; fi
      if [ $(ls -1 ~/Pictures/Wallpapers | wc -l) -lt 1 ]; then	notify-send -t 9000 "The wallpaper folder is expected to have more than 1 image. Exiting Wallsetter." && exit 1; fi

      while true; do
        while [ "$WALLPAPER" == "$PREVIOUS" ]; do
          WALLPAPER=$(find ~/Pictures/Wallpapers -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
        done

        PREVIOUS=$WALLPAPER

        ${pkgs.swww}/bin/swww img "$WALLPAPER" --transition-type random --transition-step 1 --transition-fps 60
        sleep $TIMEOUT
      done
    '')
  ];
}
