{ config, pkgs, hostname, mainUser, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/core/default.nix
    ../../modules/desktop/default.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "${hostname}";
  networking.networkmanager.enable = true;

  users.users."${mainUser}" = {
    isNormalUser = true;
    description = "${mainUser}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "26.05";
}
