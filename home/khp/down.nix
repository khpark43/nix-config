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
    # ./desktop/kitty.nix
    ./cli/zsh.nix
    ./cli/git.nix
    ./cli/gpg.nix
  ];
  home = {
    username = "khp";
    homeDirectory = "/home/khp";
    packages = [ inputs.nvf.packages.${pkgs.system}.default ];

    file = {
      # ".screenrc".source = dotfiles/screenrc;
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
    # Please read the comment before changing.
    stateVersion = "24.05";
  };
  programs = {
    home-manager.enable = true;
    ripgrep.enable = true;
    htop.enable = true;
    btop.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
