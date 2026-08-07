{ config, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.mpv.enable = true;
  home.packages = with pkgs; [
    transmission_4-gtk
  ];
}
