{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../modules/core/default.nix
    ../../modules/server/k3s.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "srv-constructor";
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  ##############################################################################
  # User tristan
  ##############################################################################
  users.users.tristan = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDAKwYs0TA/UBPJqZCPAIcrRMJRx1DzWP6pQ02egkzaC tristan.groult@gmail.com"
    ];
  };

  system.stateVersion = "26.05";
}
