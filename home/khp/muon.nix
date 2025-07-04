{
  lib,
  pkgs,
  outputs,
  ...
}:
{
  imports = [
    ./common.nix
    ./desktop/kitty.nix
    ./cli/zsh.nix
    ./cli/gpg.nix
    ./cli/git.nix
  ];
  home-manager.enable = true;
  home = {
    activation.kitty = lib.hm.dag.entryAfter [ "writeBoundry" ] ''
      $DRY_RUN_CMD [ -f ~/Applications/kitty.app ] && rm -rf ~/Applications/kitty.app
      $DRY_RUN_CMD cp -r ${pkgs.kitty}/Applications/kitty.app/ ~/Applications
      $DRY_RUN_CMD chmod -R 755 ~/Applications/kitty.app
    '';
    username = "khp";
    homeDirectory = "/Users/khp";

    stateVersion = "24.05";

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
      # SSH_AUTH_SOCK= "/Users/khp/.bitwarden-ssh-agent.sock";
    };
  };
  programs = { };
}
