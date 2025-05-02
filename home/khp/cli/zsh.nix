_: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
    shellAliases = {
      nr = "nixos-rebuild --flake .";
      nrs = "nixos-rebuild --flake . switch";
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";
      hm = "home-manager --flake .";
      hms = "home-manager --flake . switch";
    };
    initContent = ''
      # why need in wsl?
      function zle-keymap-select {
        case $KEYMAP in
          vicmd) echo -ne '\e[1 q' ;;  # Block cursor for normal mode
          viins|main) echo -ne '\e[5 q' ;;  # Beam cursor for insert mode
        esac
      }

      # Reset cursor when leaving ZLE (e.g., after running a command)
      function zle-line-finish {
        echo -ne '\e[5 q'
      }

      zle -N zle-keymap-select
      zle -N zle-line-finish
      bindkey -v
      autoload edit-command-line; zle -N edit-command-line
      bindkey '^v' edit-command-line

      bindkey "^?" backward-delete-char
    '';
  };
}
