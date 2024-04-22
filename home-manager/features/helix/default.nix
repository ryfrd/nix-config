{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      marksman
      python3Packages.python-lsp-server
      nil
      lua-language-server
    ];
    settings = {
      theme = "base16_transaprent"; # follows terminal colors
      editor = {
        line-number = "relative";
        cursorline = true;
        cursorcolumn = false;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        bufferline = "multiple";
        color-modes = true;
        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
            #"version-control"
          ];
          right = [ "diagnostics" "file-type" "position" ];
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        indent-guides.render = true;
      };
      keys.normal = {
        space."v" = ":vsplit-new";
        space."h" = ":hsplit-new";
      };
      keys.insert = { "A-x" = "normal_mode"; };
    };
    languages = {
      language = [
        {
          name = "nix";
          file-types = [ "nix" ];
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
        }
        {
          name = "python";
          file-types = [ "py" ];
          auto-format = true;
          formatter.command = "${pkgs.ruff}/bin/ruff format";
        }
        {
          name = "lua";
          file-types = [ "lua" ];
          auto-format = true;
          formatter.command = "${pkgs.stylua}/bin/stylua";
        }
      ];
    };
  };
}
