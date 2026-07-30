{ config, pkgs, ... }:

let
  c = config.theme.colors;
in
{
  wayland.windowManager.sway = {
    enable = true;
    
    config.modifier = "Mod4";
    config.terminal = "alacritty";
    
    config.gaps = {
      inner = 8;
      outer = 0;
    };
    
    config.window = {
      border = 2; 
    };

    config.bars = [
      { command = "waybar"; }
    ];

    config.colors = {
      focused = {
        background = "${c.accent}";
        border = "${c.bg}";
        childBorder = "${c.accent}";
        indicator = "${c.bg_alt}";
        text = "${c.bg}";
      };
      focusedInactive = {
        background = "${c.bg_alt}";
        border = "${c.bg}";
        childBorder = "${c.bg_alt}";
        indicator = "${c.bg_alt}";
        text = "${c.fg}";
      };
      unfocused = {
        background = "${c.bg}";
        border = "${c.bg}";
        childBorder = "${c.bg}";
        indicator = "${c.bg_alt}";
        text = "${c.fg}";
      };
      urgent = {
        background = "${c.red}";
        border = "${c.red}";
        childBorder = "${c.red}";
        indicator = "${c.red}";
        text = "${c.bg}";
      };
    };

    config.output = {
      "*" = {
        # Fetch wallpaper from the nix store
        bg = "${config.theme.wallpaper} fill";
      };
    };

    config.startup = [
      { 
        command = "systemctl --user restart kanshi.service"; 
        always = true; 
      }
      {
        command = "blueman-applet";
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
