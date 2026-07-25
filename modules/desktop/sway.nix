{ pkgs, ... }:

{
  programs.sway.enable = true;

  hardware.graphics.enable = true;

  # Un gestionnaire de connexion moderne compatible Wayland
  # SDDM est très robuste pour lancer des sessions Wayland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  security.polkit.enable = true;
}
