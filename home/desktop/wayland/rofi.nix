{ config, pkgs, ... }:

let
  c = config.theme.colors;
  f = config.theme.fonts;

  rofi-menus = pkgs.writeShellScriptBin "rofi-menus" ''
    case "$1" in
      bluetooth)
        exec ${pkgs.rofi-bluetooth}/bin/rofi-bluetooth
        ;;
      power)
        action=$(echo -e "Lock\nSuspend\nReboot\nShutdown" | ${pkgs.rofi}/bin/rofi -dmenu -i -p "Power")
        case "$action" in
          Lock) exec hyprlock ;;
          Suspend) exec systemctl suspend ;;
          Reboot) exec systemctl reboot ;;
          Shutdown) exec systemctl poweroff ;;
        esac
        ;;
      performance)
        action=$(echo -e "performance\nbalanced\npower-saver" | ${pkgs.rofi}/bin/rofi -dmenu -i -p "Performance")
        if [ -n "$action" ]; then
          exec powerprofilesctl set "$action"
        fi
        ;;
    esac
  '';
in
{
  home.packages = with pkgs; [
    rofi-menus
    rofi-bluetooth
  ];

  xdg.desktopEntries = {
    "rofi-bluetooth" = {
      name = "Bluetooth Menu";
      exec = "${rofi-menus}/bin/rofi-menus bluetooth";
      terminal = false;
      categories = [
        "System"
        "Settings"
      ];
    };
    "rofi-power" = {
      name = "Power Menu";
      exec = "${rofi-menus}/bin/rofi-menus power";
      terminal = false;
      categories = [
        "System"
        "Settings"
      ];
    };
    "rofi-performance" = {
      name = "Performance Menu";
      exec = "${rofi-menus}/bin/rofi-menus performance";
      terminal = false;
      categories = [
        "System"
        "Settings"
      ];
    };
  };

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
          placeholder = "Search...";
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
