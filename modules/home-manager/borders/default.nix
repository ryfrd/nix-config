{ lib, config, ... }:

let
  cfg = config.borderValues;
in

{
  options.borderValues = {
    enable = lib.mkEnableOption "Whether to enable border values";
    width = lib.mkOption {
      type = lib.types.str;
      default = "2";
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
