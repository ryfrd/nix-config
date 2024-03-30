{ pkgs, ... }: {
   programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ];
    #keybindings = {};
    mutableExtensionsDir = false;
    userSettings = {
      "editor.tabSize" = 2;
    };
  };
}
