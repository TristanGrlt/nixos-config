{ config, lib, ... }:

let
  c = config.theme.colors;
  f = config.theme.fonts;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      keyboard.bindings = [
        {
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
      ];
      font = {
        normal.family = lib.mkForce f.monospace;
        size = lib.mkForce 11;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = false;
      window.opacity = 0.95;
      colors = {
        primary = {
          background = c.bg;
          foreground = c.fg;
        };
        normal = {
          black = c.bg_alt;
          red = c.red;
          green = c.green;
          yellow = c.yellow;
          blue = c.blue;
          magenta = c.magenta;
          cyan = c.cyan;
          white = c.white;
        };
      };
    };
  };
}
