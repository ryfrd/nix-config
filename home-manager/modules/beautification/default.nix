{ lib, config, ... }:

let
  cfg = config.borderValues;
in

{
  options.beautificationVals = {
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
  };

  config = lib.mkIf cfg.enable {};
}
