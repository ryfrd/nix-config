{
  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-*" ];
    externalInterface = "enp5s0";
  };
}
