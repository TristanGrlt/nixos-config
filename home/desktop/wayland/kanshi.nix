{ config, pkgs, lib, ... }:

{
  programs.firefox.enable = true;
  # UI for monitors
  home.packages = with pkgs; [
    wdisplays
  ];

  services.kanshi = {
    enable = true;
  };
}
