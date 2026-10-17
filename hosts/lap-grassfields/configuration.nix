{
  pkgs,
  hostname,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./nvidia.nix

    ../../modules/core/default.nix
    ../../modules/desktop/default.nix
    ../../modules/virtu/default.nix
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "btrfs" ];

  networking.hostName = "${hostname}";
  networking.networkmanager.enable = true;

  programs.zsh.enable = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  ##############################################################################
  # User tristan
  ##############################################################################
  users.users.tristan = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "kvm"
      "libvirtd"
    ];
    shell = pkgs.zsh;
  };
  home-manager.users.tristan = import ../../users/tristan/desktop.nix;

  # support for dev tools
  programs.nix-ld.enable = true;

  system.stateVersion = "26.05";
}
