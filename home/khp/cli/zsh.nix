_: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    autosuggestion.enable = true;
    shellAliases = {
      nr = "nixos-rebuild --flake .";
      nrs = "nixos-rebuild --flake . switch";
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";
      hm = "home-manager --flake .";
      hms = "home-manager --flake . switch";
    };
    initExtra = ''
      autoload edit-command-line; zle -N edit-command-line
      bindkey '^v' edit-command-line

      bindkey "^?" backward-delete-char
    '';
  };
}
