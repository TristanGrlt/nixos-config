{ config, pkgs, lib, ... }:

let
  c = config.theme.colors;
  f = config.theme.fonts;
in
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        normal.family = lib.mkForce f.monospace;
        size = lib.mkForce 11;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      colors = {
        primary = {
          background = c.bg;
          foreground = c.fg;
        };
        normal = {
          black   = c.bg_alt;
          red     = c.red;
          green   = c.green;
          yellow  = c.yellow;
          blue    = c.blue;
          magenta = c.magenta;
          cyan    = c.cyan;
          white   = c.white;
        };
      };
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      "github.com" = {
        IdentityFile = "~/.ssh/git_tristanGrlt";
      };
    };
  };

  home.stateVersion = "26.05";
}
