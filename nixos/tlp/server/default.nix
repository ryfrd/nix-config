{ pkgs, ... }: {
  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE=1;
      TLP_DEFAULT_MODE="AC";
      TLP_PERSISTENT_DEFAULT = 1;
      BAY_POWEROFF_ON_AC=1;
      PLATFORM_PROFILE_ON_AC="low-power";
      CPU_SCALING_GOVERNOR_ON_AC="powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC="power";
      CPU_HWP_ON_AC="power";
      CPU_BOOST_ON_AC=0;
      SCHED_POWERSAVE_ON_AC=1;
      ENERGY_PERF_POLICY_ON_AC="power";
      DEVICES_TO_DISABLE_ON_STARTUP="bluetooth wifi wwan";
    };
  };
}
