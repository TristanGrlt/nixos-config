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

     # Workspaces
     "Mod4+ampersand" = "workspace number 1";
     "Mod4+eacute" = "workspace number 2";
     "Mod4+quotedbl" = "workspace number 3";
     "Mod4+apostrophe" = "workspace number 4";
     "Mod4+parenleft" = "workspace number 5";
     "Mod4+minus" = "workspace number 6";
     "Mod4+egrave" = "workspace number 7";
     "Mod4+underscore" = "workspace number 8";
     "Mod4+ccedilla" = "workspace number 9";
     "Mod4+agrave" = "workspace number 10";
 
     # Move workspaces
     "Mod4+Shift+ampersand" = "move container to workspace number 1";
     "Mod4+Shift+eacute" = "move container to workspace number 2";
     "Mod4+Shift+quotedbl" = "move container to workspace number 3";
     "Mod4+Shift+apostrophe" = "move container to workspace number 4";
     "Mod4+Shift+parenleft" = "move container to workspace number 5";
     "Mod4+Shift+minus" = "move container to workspace number 6";
     "Mod4+Shift+egrave" = "move container to workspace number 7";
     "Mod4+Shift+underscore" = "move container to workspace number 8";
     "Mod4+Shift+ccedilla" = "move container to workspace number 9";
     "Mod4+Shift+agrave" = "move container to workspace number 10";

     # Toggle SwayNC control center
     "Mod4+Shift+n" = "exec swaync-client -t -sw";
  };
}
