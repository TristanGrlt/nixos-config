{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../modules/core/default.nix
    ../../modules/server/k3s.nix
    ../../modules/server/wifi.nix
  ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Diable lid and power saver
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # Network
  networking.hostName = "srv-constructor";
  networking.networkmanager.enable = true;
  hardware.enableRedistributableFirmware = true;

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # No sudo password
  security.sudo.wheelNeedsPassword = false;

  # Sudo trusted for the nix store
  nix.settings.trusted-users = [
    "@wheel"
  ];

  # Users
  users.users = {
    ##############################################################################
    # User root
    ##############################################################################
    root = {
      hashedPassword = "!";
    };
    ##############################################################################
    # User tristan
    ##############################################################################
    tristan = {
      isNormalUser = true;
      hashedPassword = "!";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDAKwYs0TA/UBPJqZCPAIcrRMJRx1DzWP6pQ02egkzaC tristan.groult@gmail.com"
      ];
    };
  };

  system.stateVersion = "26.05";
}
