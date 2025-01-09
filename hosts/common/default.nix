{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
