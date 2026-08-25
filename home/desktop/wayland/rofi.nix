{ config, ... }:
let
  c = config.theme.colors;
  f = config.theme.fonts;
in
{
  programs.rofi = {
    enable = true;

    extraConfig = {
      show-icons = true;
      display-drun = "Apps";
      drun-display-format = "{name}";
    };

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "${c.fg}";
          font = "${f.monospace} 11";
        };

        "window" = {
          background-color = mkLiteral "${c.bg}";
          border = mkLiteral "3px";
          border-color = mkLiteral "${c.bg_alt}";
          border-radius = mkLiteral "10px";
          width = mkLiteral "450px";
        };

        "inputbar" = {
          background-color = mkLiteral "${c.bg_alt}";
          border = mkLiteral "1px";
          border-color = mkLiteral "${c.fg_muted}";
          border-radius = mkLiteral "5px";
          margin = mkLiteral "10px 10px 5px 10px";
          padding = mkLiteral "6px";
          children = map mkLiteral [ "entry" ];
        };

        "entry" = {
          text-color = mkLiteral "${c.fg}";
          placeholder = "Rechercher...";
        };

        "listview" = {
          margin = mkLiteral "5px 0px 15px 0px";
          lines = 8;
          columns = 1;
          fixed-height = mkLiteral "false";
        };

        "element" = {
          padding = mkLiteral "8px 12px";
          margin = mkLiteral "4px 15px";
          border-radius = mkLiteral "5px";
          background-color = mkLiteral "transparent";
        };

        "element selected" = {
          background-color = mkLiteral "${c.accent}";
          border = mkLiteral "1px";
          border-color = mkLiteral "${c.accent}";
        };

        "element-text" = {
          text-color = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          background-color = mkLiteral "transparent";
        };

        "element-icon" = {
          size = mkLiteral "1em";
          margin = mkLiteral "0 8px 0 0";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
        };
      };
  };
}
