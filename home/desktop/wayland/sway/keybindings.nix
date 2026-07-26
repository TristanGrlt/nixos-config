{ lib, pkgs, ... }:

{
  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "Mod4+Return" = "exec alacritty";			# launch alacritty terminal
    "Mod4+b" = "exec firefox";				# launch firefox
    "Mod4+d" = "exec wofi --show drun";			# launch wofi (app launcher)
    "Mod4+Shift+q" = "kill";				# kill selected window
    "Mod4+Shift+c" = "reload";				# reload sway
    "Mod4+Mod1+l" = "exec swaylock -f -c 000000";	# lock the session

    # Media control
    "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
    "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
    "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
    "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

    # Volume control (with avizo)
    "XF86AudioRaiseVolume" = "exec volumectl -u up";
    "XF86AudioLowerVolume" = "exec volumectl -u down";
    "XF86AudioMute" = "exec volumectl toggle-mute";

    # Light control (with avizo)
    "XF86MonBrightnessUp" = "exec lightctl up";
    "XF86MonBrightnessDown" = "exec lightctl down";
  };
}
