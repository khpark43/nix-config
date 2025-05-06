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
  };
  programs = {
    zsh.enable = true;
  };
  documentation.man.enable = true;
  environment.systemPackages = [ pkgs.man-pages ];
  time.timeZone = "Asia/Seoul";
  i18n.defaultLocale = "en_US.UTF-8";
}
