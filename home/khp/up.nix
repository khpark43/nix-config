{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    ./desktop/firefox.nix
    ./desktop/kitty.nix
    ./cli/zsh.nix
    ./cli/git.nix
    ./cli/gpg.nix
  ];
  home = {
    username = "khp";
    homeDirectory = "/home/khp";

    packages = [
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      pkgs.neofetch
      pkgs.wl-clipboard
      pkgs.zed-editor
      outputs.packages.${pkgs.system}.my-neovim
    ];

    file = {
      # ".screenrc".source = dotfiles/screenrc;
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "${pkgs.firefox}/bin/firefox";
    };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
    ripgrep.enable = true;
    htop.enable = true;
    btop.enable = true;
    gnome-shell = {
      enable = true;
      extensions = [{package = pkgs.gnomeExtensions.kimpanel;}];
    };
    chromium = {
      enable = true;
      extensions = [
        {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      ];
      commandLineArgs = ["--ignore-gpu-blocklist"];
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    vscode = {
      enable = true;
      extensions = [
        pkgs.vscode-extensions.vscodevim.vim
        pkgs.vscode-extensions.ms-python.python
        pkgs.vscode-extensions.ms-python.vscode-pylance
        pkgs.vscode-extensions.ms-python.debugpy
        pkgs.vscode-extensions.mhutchie.git-graph
        pkgs.vscode-extensions.eamodio.gitlens
      ];
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-hangul
    ];
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  }; # Please read the comment before changing.
}
