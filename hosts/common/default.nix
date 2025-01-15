{ inputs, config, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./sops.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.access-tokens = ''
    !include ${config.sops.secrets.github-personal-access-token.path}";
  '';
}
