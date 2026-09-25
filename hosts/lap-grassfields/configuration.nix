{
  pkgs,
  hostname,
  username,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./nvidia.nix

    ../../modules/core/default.nix
    ../../modules/desktop/default.nix
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

  users.users."${username}" = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    shell = pkgs.zsh;
  };

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  # support for dev tools
  programs.nix-ld.enable = true;

  system.stateVersion = "26.05";
}
