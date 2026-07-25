{ lib, ... }:

{
  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "Mod4+Return" = "exec alacritty";
    "Mod4+b" = "exec firefox";
    "Mod4+Shift+q" = "kill";
    "Mod4+Shift+c" = "reload";
  };
}
