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

  time.timeZone = "Asia/Seoul";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.khp = {
    isNormalUser = true;
    description = "Kyunghyun Park";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    kitty
  ];

  environment.variables = {
    EDITOR = "vim";
  };
  system.stateVersion = "24.05";
}
