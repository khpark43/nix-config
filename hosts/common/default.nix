{ inputs, config, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./sops.nix
    ./fonts.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.access-tokens = ''
    !include ${config.sops.secrets.github-personal-access-token.path}";
  '';
  programs = {
    zsh.enable = true;
    man.enable = true;
  };
  time.timeZone = "Asia/Seoul";
  i18n.defaultLocale = "en_US.UTF-8";
}
