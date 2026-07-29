{ config, pkgs, ... }:

let
  c = config.theme.colors;
  f = config.theme.fonts;

  # Convert "#RRGGBB" to "rgb(RRGGBB)" for Hyprlock parser
  hex = color: "rgb(" + builtins.substring 1 6 color + ")";
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
      };

      background = [
        {
          monitor = "";
          path = "${config.theme.wallpaper}";
          color = hex c.bg;
          blur_passes = 2;
          blur_size = 4;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";

          # Force square borders and password dots
          rounding = 1;
          dots_rounding = 0;

          dots_size = 0.30;
          dots_spacing = 0.22;
          dots_center = true;

          inner_color = hex "#ffffff";
          font_color = hex c.bg;

          fade_on_empty = false;
          placeholder_text = "Password...";
          hide_input = false;

          check_color = hex c.yellow;

          fail_color = hex c.red;
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";

          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = hex "#ffffff";
          font_size = 90;
          font_family = "${f.monospace} Bold";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:18000000] date +"<b>%A %-d %B</b>"'';
          color = hex "#ffffff";
          font_size = 20;
          font_family = "${f.monospace}";
          position = "0, 10";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
