{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
  ];

  services.cliphist = {
    enable = true;
  };

  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "Mod4+v" = "exec cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy";
  };
}
