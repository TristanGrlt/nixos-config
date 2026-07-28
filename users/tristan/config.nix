{ config, pkgs, lib, ... }:

let
  c = config.theme.colors;
in
{
  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        normal.family = lib.mkForce "SpaceMono Nerd Font";
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
    # La nouvelle méthode centralise tout dans 'settings'
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
