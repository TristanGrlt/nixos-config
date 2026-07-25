{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; 

  # bluetooth conf UI
  services.blueman.enable = true;
}
