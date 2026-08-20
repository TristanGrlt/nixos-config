{ config, lib, pkgs, ... }:

let
  c = config.theme.colors;
  f = config.theme.fonts;
in {
  home.packages = with pkgs; [
    sov
  ];
 
  # Startup & Hold-to-Show
  wayland.windowManager.sway.config = {
    startup = [
      {
        command = "rm -f /tmp/sovpipe && mkfifo /tmp/sovpipe && tail -f /tmp/sovpipe | sov";
        always = true;
      }
    ];

    keybindings = lib.mkOptionDefault {
      "--no-repeat Mod4+Tab" = "exec echo 1 > /tmp/sovpipe";
      "--release Mod4+Tab" = "exec echo 0 > /tmp/sovpipe";
    };
  };
}
