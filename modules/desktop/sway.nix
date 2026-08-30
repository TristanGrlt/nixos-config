{ pkgs, ... }:

{
  # Sway window manager
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };

  hardware.graphics.enable = true;

  # Enable lightness control without sudo
  hardware.acpilight.enable = true;

  security.polkit.enable = true;
  # Authorise swaylock to verify password
  security.pam.services.hyprlock = { };

  # USB & Trash
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
