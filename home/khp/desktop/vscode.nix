{ pkgs, lib, ... }:
{
  programs = {
    vscode = {
      enable = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          # vscodevim.vim
          ms-python.python
          ms-python.vscode-pylance
          ms-python.debugpy
          mhutchie.git-graph
          eamodio.gitlens
          jnoortheen.nix-ide
          # rust-lang.rust-analyzer
          ms-vscode.cpptools
          ms-vscode.cpptools-extension-pack
          ms-azuretools.vscode-docker
        ];
        userSettings = ({
          editor.fontFamily = "JetBrainsMono Nerd Font";
          editor.fontLigatures = true;
          terminal.integrated.fontFamily = "JetBrainsMono Nerd Font";
          python.analysis.typeCheckingMode = "standard";
        });
      };
    };
  };
}
