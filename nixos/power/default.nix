{ pkgs, ... }:{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
    scsiLinkPolicy = "min_power";
  };
}
