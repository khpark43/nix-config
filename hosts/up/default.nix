{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./thunar.nix
    ../common
  ];
  virtualisation.docker.enable = true;
  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
  };

  networking = {
    hostName = "up";
    # FIXME: wol
    interfaces.enp5s0.wakeOnLan.enable = true;
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-hangul # 한글 엔진
          fcitx5-configtool # GUI 설정 툴
          fcitx5-gtk # GTK/Qt 브리지
        ];
      };
    };
    extraLocaleSettings = {
      LC_ADDRESS = "ko_KR.UTF-8";
      LC_IDENTIFICATION = "ko_KR.UTF-8";
      LC_MEASUREMENT = "ko_KR.UTF-8";
      LC_MONETARY = "ko_KR.UTF-8";
      LC_NAME = "ko_KR.UTF-8";
      LC_NUMERIC = "ko_KR.UTF-8";
      LC_PAPER = "ko_KR.UTF-8";
      LC_TELEPHONE = "ko_KR.UTF-8";
      LC_TIME = "ko_KR.UTF-8";
    };
  };

  services = {
    displayManager = {
      enable = true;
      defaultSession = "hyprland";
      gdm.enable = true;
      gdm.autoSuspend = false;
    };
    desktopManager.gnome.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };
      desktopManager.runXdgAutostartIfNone = true;
    };

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        AllowUsers = [ "khp" ];
        UseDns = true;
        X11Forwarding = true;
        PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    tumbler.enable = true;
  };

  security.rtkit.enable = true;

  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.bluetooth = {
    enable = true;
  };

  stylix = {
    enable = true;
    image = ../../wallpapers/City-Night.png;
    # base16Scheme = {
    #   base00 = "282936";
    #   base01 = "3a3c4e";
    #   base02 = "4d4f68";
    #   base03 = "626483";
    #   base04 = "62d6e8";
    #   base05 = "e9e9f4";
    #   base06 = "f1f2f8";
    #   base07 = "f7f7fb";
    #   base08 = "ea51b2";
    #   base09 = "b45bcf";
    #   base0A = "00f769";
    #   base0B = "ebff87";
    #   base0C = "a1efe4";
    #   base0D = "62d6e8";
    #   base0E = "b45bcf";
    #   base0F = "00f769";
    # };
    polarity = "dark";
    opacity.terminal = 1.0;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };

  users.users.khp = {
    isNormalUser = true;
    description = "Kyunghyun Park";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh; # ?
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGzckBKke3xDDEEvfN9olIdO84GOHjCdceAiORntzEX2 khp@muon"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      git
      vim
      wget
      curl
      vesktop
      cudatoolkit
      linuxPackages.nvidia_x11
      vlc
      freecad
      kicad
      networkmanagerapplet
      pavucontrol
      libnotify
      xdg-desktop-portal-hyprland
      (chromium.override { enableWideVine = true; })
      mpv
      ffmpeg
      hyprprop
      cliphist
    ];
    variables = {
      EDITOR = "vim";
    };

    gnome.excludePackages = with pkgs; [
      epiphany
      geary
    ];

    sessionVariables = {
      # NIXOS_OZONE_WL = "1";
      CHROMIUM_FLAGS = lib.concatStringsSep " " [
        "--wayland-text-input-version=4"
        "--gtk-version=4"
      ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.steam.enable = true;
  programs.hyprland = {
    enable = true;
    # xwayland.enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05";
}
