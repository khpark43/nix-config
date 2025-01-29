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
  home.activation.kitty = lib.hm.dag.entryAfter [ "writeBoundry" ] ''
    $DRY_RUN_CMD [ -f ~/Applications/kitty.app ] && rm -rf ~/Applications/kitty.app
    $DRY_RUN_CMD cp -r ${pkgs.kitty}/Applications/kitty.app/ ~/Applications
    $DRY_RUN_CMD chmod -R 755 ~/Applications/kitty.app
  '';
  home.username = "khp";
  home.homeDirectory = "/Users/khp";

  home.stateVersion = "24.05";

  home.packages = [ outputs.packages.${pkgs.system}.my-neovim ];

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
  programs = {
    home-manager.enable = true;
    ripgrep.enable = true;
    htop.enable = true;
    btop.enable = true;
    fzf.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
