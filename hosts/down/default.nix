{ config, pkgs, ... }:

{
  imports = [ ../common ];
  wsl = {
    enable = true;
    defaultUser = "khp";
    startMenuLaunchers = true;
  };

  networking.hostName = "down";

  virtualisation.docker.enable = true;

  users.users.khp = {
    isNormalUser = true;
    description = "Kyunghyun Park";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  services.xserver.enable = true;

  environment = {
    systemPackages = with pkgs; [
      git
      vim
      wget
      curl
      kitty
    ];

    variables = {
      EDITOR = "vim";
    };
  };
  system.stateVersion = "24.05";
}
