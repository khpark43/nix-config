{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./sops.nix
    ./fonts.nix
  ];
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    access-tokens = ''
      !include ${config.sops.secrets.github-personal-access-token.path}";
    '';
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  programs = {
    zsh.enable = true;
  };
  documentation.man.enable = true;
  environment.systemPackages = [ pkgs.man-pages ];
  time.timeZone = "Asia/Seoul";
  i18n.defaultLocale = "en_US.UTF-8";
}
