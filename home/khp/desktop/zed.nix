{
  pkgs,
  lib,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "catppuccin"
      "nix"
    ];
    userSettings = {
      theme = lib.mkDefault "Catppuccin Mocha";
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = true;
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
        };
      };
      lsp = {
        nil = {
          initialization_options = {
            formatting = {
              command = [ "nixfmt" ];
            };
          };
          settings = {
            diagnostics = {
              ignored = [ "unused_binding" ];
            };
          };
        };
      };
    };
  };
}
