{ lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "Kyunghyun Park";
    userEmail = "me@khp.dev";
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgSign = lib.mkDefault true;
    };
  };
}
