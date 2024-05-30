{ lib, config, ... }:

let cfg = config.borderValues;

in {
  options.beautification = {
    enable = lib.mkEnableOption "Whether to enable beautification values";
    width = lib.mkOption {
      type = lib.types.str;
      default = "1";
    };
    radius = lib.mkOption {
      type = lib.types.str;
      default = "0";
    };
    gap = lib.mkOption {
      type = lib.types.str;
      default = "0";
    };
    fontName = lib.mkOption {
      type = lib.types.str;
      default = "Agave Nerd Font";
    };
  };

  config = lib.mkIf cfg.enable { };
}
