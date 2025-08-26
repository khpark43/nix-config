{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    swww
    grim
    slurp
    wl-clipboard
    swappy
    ydotool
    hyprpolkitagent
    hyprland-qtutils # needed for banners and ANR messages
    swww
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../../wallpapers;
      recursive = true;
    };
    # ".face.icon".source = ./face.jpg;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
    settings = {
      "exec-once" = [
        "wl-paste --type text --watch cliphist store # Stores only text data"
        "wl-paste --type image --watch cliphist store # Stores only image data"
        "killall -q waybar;sleep .5 && waybar"
        "killall -q swww-daemon;sleep .5 && swww-daemon"
        # "killall -q swaync;sleep .5 && swaync"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user start hyprpolkitagent"
        "pypr &"
      ];
      # exec-once = [
      #   "wl-paste --type text --watch cliphist store # Stores only text data"
      #   "wl-paste --type image --watch cliphist store # Stores only image data"
      #   "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      #   "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      #   "systemctl --user start hyprpolkitagent"
      #   "killall -q waybar;sleep .5 && waybar"
      #   "killall -q swaync;sleep .5 && swaync"
      #   "nm-applet --indicator"
      #   "pypr &"
      # ];
      monitor = "DP-1, 2560x1440@144, 0x0, 1";
      input = {
        kb_layout = "us";
        repeat_delay = 300;
        follow_mouse = 1;

        float_switch_override_focus = 0;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap-to-click = true;
          scroll_factor = 0.5;
          drag_3fg = 1;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
        workspace_swipe_distance = 700;
        workspace_swipe_invert = 1;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.2;
        workspace_swipe_create_new = 1;
        workspace_swipe_forever = 1;
      };
      general = {
        "$modifier" = "SUPER";
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" =
          "rgb(${config.lib.stylix.colors.base08}) rgb(${config.lib.stylix.colors.base0C}) 45deg";
        "col.inactive_border" = "rgb(${config.lib.stylix.colors.base01})";
      };
      debug.disable_logs = false;
      misc = {
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = false;
        vfr = true; # Variable Frame Rate
        vrr = 2; # Variable Refresh Rate  Might need to set to 0 for NVIDIA/AQ_DRM_DEVICES
        # Screen flashing to black momentarily or going black when app is fullscreen
        # Try setting vrr to 0
        #  Application not responding (ANR) settings
        enable_anr_dialog = true;
        anr_missed_pings = 20;
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          # color = "rgba(1a1a1aee)";
        };

      };
      ecosystem = {
        no_donation_nag = true;
        no_update_news = false;
      };
      cursor = {
        sync_gsettings_theme = true;
        no_hardware_cursors = 2; # change to 1 if want to disable
        enable_hyprcursor = false;
        warp_on_change_workspace = 2;
        no_warps = true;
      };
      render = {
        direct_scanout = 0;
      };
      master = {
        new_status = "master";
        new_on_top = 1;
        mfact = 0.5;
      };
    };
  };
}
