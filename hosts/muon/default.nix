{
  pkgs,
  inputs,
  ...
}:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  users.users.khp = {
    home = "/Users/khp"; # 본인 계정 경로
    shell = pkgs.zsh; # 선택
  };
  environment.systemPackages = [
    pkgs.vim
    pkgs.ripgrep
    # pkgs.remmina
    inputs.nixpkgs-stable.legacyPackages.aarch64-darwin.remmina
  ];

  launchd.user.envVariables = {
    SSH_AUTH_SOCK = "/Users/khp/.bitwarden-ssh-agent.sock";
  };

  system.primaryUser = "khp";

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system.configurationRevision = null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
