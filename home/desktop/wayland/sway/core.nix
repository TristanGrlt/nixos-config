{ ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config.modifier = "Mod4";
    config.terminal = "alacritty";
    extraSessionCommands = ''
      export MOZ_ENABLE_WAYLAND=1
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=sway
    '';
  };
}
