{ pkgs, ... }:
{
  programs = {
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        ms-python.python
        ms-python.vscode-pylance
        ms-python.debugpy
        mhutchie.git-graph
        eamodio.gitlens
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
      ];
    };
  };
}
