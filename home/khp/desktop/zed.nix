{
  pkgs,
  lib,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    extensions = [ "catppuccin" ];
    userSettings = {
      theme = "Catppuccin Mocha";
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = true;
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter = {
            external = {
              command = "nixfmt";
            };
          };
        };
      };
    };
  };
}
