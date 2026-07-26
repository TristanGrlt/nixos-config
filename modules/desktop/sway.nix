{ pkgs, ... }:

{
  # Sway window manager
  programs.sway.enable = true;
  hardware.graphics.enable = true;

  # Session launcher
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  security.polkit.enable = true;
  # Authorise swaylock to verify password 
  security.pam.services.swaylock = {};
}
