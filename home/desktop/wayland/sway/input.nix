{ ... }:

{
  wayland.windowManager.sway.config.input = {
    "type:keyboard".xkb_layout = "fr";
    "type:touchpad" = {
      tap = "enabled";
      dwt = "enabled";
    };
  };
}
