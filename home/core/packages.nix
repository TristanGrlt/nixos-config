{ pkgs, ... }:
{
  programs.mpv.enable = true;

  programs.chromium = {
    enable = true;
    package = pkgs.brave-origin;
  };

  home.packages = with pkgs; [
    transmission_4-gtk
    aircrack-ng

    gnome-calculator
    snapshot
    baobab
    gnome-disk-utility
    simple-scan
    evince
    loupe

    pantheon.elementary-calendar
    thunar
    thunar-volman
    thunar-archive-plugin
  ];
}
