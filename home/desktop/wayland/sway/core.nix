{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config.modifier = "Mod4";
    config.terminal = "alacritty";

    config.gaps = {
      inner = 0;
      outer = 0;
    };

    config.window = {
      border = 0;
    };

    config.startup = [
      { 
        command = "systemctl --user restart kanshi.service"; 
        always = true; 
      }
    ];

    extraSessionCommands = ''
      export MOZ_ENABLE_WAYLAND=1
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=sway
    '';
  };
}
