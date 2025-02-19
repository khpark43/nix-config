_: {
  programs = {
    home-manager.enable = true;
    ripgrep.enable = true;
    htop.enable = true;
    btop.enable = true;
    fzf.enable = true;
    lazygit.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
