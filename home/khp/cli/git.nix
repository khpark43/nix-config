{ lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "Kyunghyun Park";
    userEmail = lib.mkDefault "me@khp.dev";
    extraConfig = {
      init.defaultBranch = "main";
      user.signing.key = "3586A37F5FBE2C33F3563DA82ABFA32C5F0545FF";
      commit.gpgSign = lib.mkDefault true;
      push.autoSetupRemote = true;
    };
    ignores = [
      ".direnv"
      "result"
    ];
  };
}
