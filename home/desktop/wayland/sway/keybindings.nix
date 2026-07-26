{ lib, ... }:

{
  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "Mod4+Return" = "exec alacritty";			# launch alacritty terminal
    "Mod4+b" = "exec firefox";				# launch firefox
    "Mod4+d" = "exec wofi --show drun";			# launch wofi (app launcher)
    "Mod4+Shift+q" = "kill";				# kill selected window
    "Mod4+Shift+c" = "reload";				# reload sway
    "Mod4+Mod1+l" = "exec swaylock -f -c 000000";	# lock the session
  };
}
