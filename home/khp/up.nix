{ pkgs, outputs, ... }:
{
  imports = [
    ./common.nix
    ./desktop/firefox.nix
    ./desktop/kitty.nix
    ./desktop/vscode.nix
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
      pkgs.bitwarden-desktop
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

    stateVersion = "24.05";
  };

  programs = {
    gnome-shell = {
      enable = true;
      extensions = [ { package = pkgs.gnomeExtensions.kimpanel; } ];
    };
    chromium = {
      enable = true;
      extensions = [
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
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
  };
}
