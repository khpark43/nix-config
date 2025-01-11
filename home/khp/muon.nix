{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
{
  imports = [
    ./desktop/kitty.nix
    ./cli/zsh.nix
    ./cli/gpg.nix
    ./cli/git.nix
  ];
  home.username = "khp";
  home.homeDirectory = "/Users/khp";

  home.stateVersion = "24.05";

  home.packages = [ inputs.nvf.packages.${pkgs.system}.default ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  programs.ripgrep.enable = true;
  programs.htop.enable = true;
  programs.btop.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
