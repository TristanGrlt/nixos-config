{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    flameshot
    grim
  ];

  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "Print" = "exec flameshot gui";
    "Mod4+Shift+s" = "exec flameshot gui";
  };
}
