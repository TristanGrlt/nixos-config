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

  # Session launcher
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  security.polkit.enable = true;
  # Authorise swaylock to verify password 
  security.pam.services.swaylock = {};
}
