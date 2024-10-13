{...}: {
  programs.git = {
    enable = true;
    userName = "khp";
    userEmail = "me@khp.dev";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
