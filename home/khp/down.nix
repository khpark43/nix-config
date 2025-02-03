{ pkgs, outputs, ... }:
{
  imports = [
    ./desktop/kitty.nix
    ./common.nix
    ./cli/zsh.nix
    ./cli/git.nix
    ./cli/gpg.nix
  ];
  home = {
    username = "khp";
    homeDirectory = "/home/khp";
    packages = [ outputs.packages.${pkgs.system}.my-neovim ];

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
  programs = { };
}
