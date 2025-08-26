{
  pkgs,
  outputs,
  lib,
  ...
}:
{
  imports = [
    ./common.nix
    ./desktop/firefox.nix
    ./desktop/kitty.nix
    ./desktop/vscode.nix
    ./desktop/zed.nix
    ./cli/zsh.nix
    ./cli/git.nix
    ./cli/gpg.nix
    ./hyprland
    ./waybar.nix
    ./stylix.nix
    ./rofi
    ./wlogout
    ./scripts.nix
    ./emoji.nix
    ./fastfetch
    ./swaync.nix
  ];

  services = {
    hyprpaper = {
      enable = true;
    };
    nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
    remmina.enable = true;
  };

  home = {
    packages = [
      pkgs.neofetch
      pkgs.wl-clipboard
      pkgs.bitwarden-desktop
      # pkgs.nixd
      pkgs.nil
      pkgs.nixfmt-rfc-style
      pkgs.telegram-desktop
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
      BROWSER = "${pkgs.brave}/bin/brave";
    };

    stateVersion = "24.05";
  };

  programs = {
    hyprlock = {
      enable = true;
    };
    gnome-shell = {
      enable = true;
      extensions = [ { package = pkgs.gnomeExtensions.kimpanel; } ];
    };
    chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
    };
  };
}
