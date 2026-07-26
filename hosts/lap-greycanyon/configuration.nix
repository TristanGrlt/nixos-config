{ config, pkgs, hostname, username, ... }:

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

  users.users."${username}" = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  system.stateVersion = "26.05";
}
