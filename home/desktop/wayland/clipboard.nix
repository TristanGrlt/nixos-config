{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
  ];

  services.cliphist = {
    enable = true;
  };

  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "Mod4+v" = "exec cliphist list | wofi --show dmenu --width 800 | cliphist decode | wl-copy";
  };
}
