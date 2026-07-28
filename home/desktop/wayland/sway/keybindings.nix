{ lib, pkgs, ... }:

{
  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "Mod4+Return" = "exec alacritty"; 
    "Mod4+b" = "exec firefox"; 
    "Mod4+d" = "exec wofi --show drun"; 
    "Mod4+Shift+q" = "kill"; 
    "Mod4+Shift+c" = "reload"; 
    "Mod4+Mod1+l" = "exec hyprlock";

    # Media control
    "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
    "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
    "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
    "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

    # Volume control (SwayOSD)
    "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
    "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
    "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";

    # Light control (SwayOSD)
    "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
    "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";
  };
}
