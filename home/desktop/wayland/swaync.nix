{ config, pkgs, ... }:

let
  c = config.theme.colors;
  f = config.theme.fonts;
in
{
  home.packages = [ pkgs.libnotify ];
  services.swaync = {
    enable = true;
    
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      
      # Margins to detach the control center from screen edges
      control-center-margin-top = 8;
      control-center-margin-bottom = 8;
      control-center-margin-right = 5;
      control-center-margin-left = 5;
      
      control-center-width = 380;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      
      widgets = [
        "title"
        "dnd"
        "notifications"
      ];
      
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
      };
    };

    style = ''
      * {
        font-family: "${f.monospace}", monospace;
        font-weight: bold;
      }

      /* Main control center panel */
      .control-center {
        background-color: ${c.bg};
        color: ${c.fg};
        border: 1px solid ${c.bg_alt};
        border-radius: 10px;
      }

      /* Title widget */
      .widget-title {
        color: ${c.accent};
        font-size: 18px;
        padding: 10px 15px;
      }

      .widget-title > button {
        font-size: 12px;
        color: ${c.bg};
        background-color: ${c.accent};
        border-radius: 5px;
        padding: 4px 10px;
        border: none;
      }

      .widget-title > button:hover {
        background-color: ${c.yellow};
      }

      /* Do Not Disturb widget */
      .widget-dnd {
        background-color: ${c.bg_alt};
        padding: 10px 15px;
        border-radius: 5px;
        margin: 5px 15px 15px 15px;
        color: ${c.fg};
        font-size: 14px;
        border: 1px solid ${c.fg_muted};
      }

      .widget-dnd > switch {
        background-color: ${c.bg};
        border-radius: 5px;
      }

      .widget-dnd > switch:checked {
        background-color: ${c.accent};
      }

      /* Notification blocks */
      .notification-row {
        outline: none;
        margin: 0 15px 10px 15px;
      }

      .notification {
        background-color: ${c.bg_alt};
        padding: 12px;
        border-radius: 5px;
        border: 1px solid ${c.fg_muted};
      }

      .notification-content {
        background-color: transparent;
        padding: 0;
        border-radius: 0;
      }

      .close-button {
        background-color: ${c.red};
        color: ${c.bg};
        text-shadow: none;
        padding: 0;
        border-radius: 5px;
        margin-top: 5px;
        margin-right: 5px;
      }

      .close-button:hover {
        background-color: ${c.accent};
      }

      /* Notification text elements */
      .summary {
        font-size: 14px;
        color: ${c.accent};
      }

      .time {
        font-size: 12px;
        color: ${c.fg_muted};
      }

      .body {
        font-size: 13px;
        font-weight: normal;
        color: ${c.fg};
        margin-top: 4px;
      }

      /* Notification actions/buttons */
      .notification-default-action,
      .notification-action {
        padding: 6px;
        margin: 4px 0 0 0;
        box-shadow: none;
        background-color: ${c.bg};
        border: 1px solid ${c.fg_muted};
        color: ${c.fg};
        border-radius: 5px;
      }

      .notification-action:hover {
        background-color: ${c.fg_muted};
      }
    '';
  };
}
