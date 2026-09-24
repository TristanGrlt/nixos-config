{
  config,
  pkgs,
  hostname,
  username,
  ...
}:

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

  programs.zsh.enable = true;

  services.ollama.enable = true;

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

  system.stateVersion = "26.05";
}
