{config, pkgs, ...}:

{
  imports = [
    ../common
  ];
  wsl.enable = true;
  wsl.defaultUser = "khp";

  networking = {
    hostName = "ng";
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];
  system.stateVersion = "24.05";
}
