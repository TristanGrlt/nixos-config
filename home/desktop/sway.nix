{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      
      keybindings = lib.mkOptionDefault {
        "Mod4+Return" = "exec alacritty";
        "Mod4+Shift+q" = "kill";
        "Mod4+Shift+c" = "reload";
      };

    };
    
    extraSessionCommands = ''
      export MOZ_ENABLE_WAYLAND=1
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=sway
    '';
  };
}
