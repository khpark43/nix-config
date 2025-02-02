{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+f" =
        "launch --type=overlay --stdin-source=@screen_scrollback ${pkgs.bash}/bin/bash -c '${pkgs.fzf}/bin/fzf --no-sort --no-mouse --exact -i --tac | kitty +kitten clipboard'";
      "cmd+f" =
        "launch --type=overlay --stdin-source=@screen_scrollback ${pkgs.bash}/bin/bash -c '${pkgs.fzf}/bin/fzf --no-sort --no-mouse --exact -i --tac | kitty +kitten clipboard'";
      "ctrl+c" = "copy_or_interrupt";
    };
    settings = {
      background_opacity = 0.85;
      window_margin_width = 0;
      cursor_blink_interval = 0;
    };
  };
}
