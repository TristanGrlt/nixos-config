{ config, pkgs, lib, ... }:

{
  programs.firefox.enable = true;
  # UI for monitors
  home.packages = with pkgs; [
    wdisplays
  ];

  # Memory on display configuration
  services.kanshi = {
    enable = true;
    profiles = {
      nomade = {
        outputs = [
          { criteria = "eDP-1"; status = "enable"; }
        ];
      };
    };
  };
}
