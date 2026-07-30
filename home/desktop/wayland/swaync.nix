{ config, pkgs, ... }:

let
  c = config.theme.colors;
  f = config.theme.fonts;
in
{
  home.packages = [
    pkgs.libnotify
    pkgs.pwvucontrol          # sound (GTK4, PipeWire) -- swap: pavucontrol
    pkgs.overskride           # bluetooth (GTK4)       -- swap: blueman
    pkgs.networkmanagerapplet # nm-connection-editor   -- swap: iwgtk / wofi menu
    pkgs.power-profiles-daemon
  ];

  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";

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
        "mpris"
        "volume"
        "slider"
        "backlight"
        "menubar"
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

        mpris = {
          show-album-art = "always";
          loop-carousel = false;
        };

        # output volume + per-app list
        volume = {
          label = "󰕾";
          show-per-app = true;
        };

        # microphone -- generic slider bound to the default source
        slider = {
          label = "󰍬";
          min = 0;
          max = 100;
          cmd_getter = "wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2*100)}'";
          cmd_setter = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ $value%";
        };

        # screen brightness -- set 'device' to yours: ls /sys/class/backlight
        backlight = {
          label = "󰃟";
          device = "intel_backlight";
          min = 5;
        };

        menubar = {
          # quick toggles: wifi / bluetooth / airplane
          "buttons#toggles" = {
            position = "left";
            actions = [
              {
                label = "󰖩";
                type = "toggle";
                command = ''bash -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off' '';
                update-command = ''bash -c '[[ $(nmcli -t radio wifi) == enabled ]] && echo true || echo false' '';
              }
              {
                label = "󰂯";
                type = "toggle";
                command = ''bash -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && rfkill unblock bluetooth || rfkill block bluetooth' '';
                update-command = ''bash -c 'rfkill list bluetooth | grep -q "Soft blocked: yes" && echo false || echo true' '';
              }
              {
                # airplane mode: active = all radios blocked
                label = "󰀝";
                type = "toggle";
                command = ''bash -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && rfkill block all || rfkill unblock all' '';
                update-command = ''bash -c 'rfkill list | grep -q "Soft blocked: yes" && echo true || echo false' '';
              }
            ];
          };

          # settings launchers (open the graphical apps)
          "menu#settings" = {
            label = "󰒓";
            position = "right";
            actions = [
              { label = "󰤨  Network"; command = "nm-connection-editor"; }
              { label = "󰂯  Bluetooth"; command = "overskride"; }
              { label = "󰕾  Sound"; command = "pwvucontrol"; }
            ];
          };

          # performance profile selector
          "menu#power" = {
            label = "󰓅";
            position = "right";
            actions = [
              { label = "󰓅  Performance"; command = "powerprofilesctl set performance"; }
              { label = "󰾅  Balanced"; command = "powerprofilesctl set balanced"; }
              { label = "󰌪  Power Saver"; command = "powerprofilesctl set power-saver"; }
            ];
          };
        };
      };
    };

    style = ''
      * {
        font-family: "${f.monospace}", monospace;
        font-weight: bold;
        font-size: 14px;
      }

      /* panel */
      .control-center {
        background-color: ${c.bg};
        color: ${c.fg};
        border: 3px solid ${c.bg_alt};
        border-radius: 10px;
      }

      .floating-notifications .notification {
        margin: 6px;
      }

      /* title */
      .widget-title {
        color: ${c.accent};
        font-size: 18px;
        padding: 10px 15px;
      }

      .widget-title > button {
        font-size: 12px;
        color: ${c.fg};
        background-color: ${c.bg_alt};
        border: 1px solid ${c.fg_muted};
        border-radius: 5px;
        padding: 4px 10px;
      }

      .widget-title > button:hover {
        background-color: ${c.accent};
        border: 1px solid ${c.accent};
        color: ${c.bg};
      }

      /* mpris */
      .widget-mpris {
        margin: 0 15px 15px 15px;
      }

      .widget-mpris-player {
        background-color: ${c.bg_alt};
        border: 1px solid ${c.fg_muted};
        border-radius: 5px;
        padding: 12px;
      }

      .widget-mpris-title {
        color: ${c.accent};
        font-size: 14px;
      }

      .widget-mpris-subtitle {
        color: ${c.fg};
        font-size: 12px;
        font-weight: normal;
      }

      .widget-mpris-player > button {
        background-color: transparent;
        border: none;
        box-shadow: none;
        color: ${c.fg};
      }

      .widget-mpris-player > button:hover {
        color: ${c.accent};
      }

      /* shrink carousel arrows so the card has room */
      .widget-mpris > box > button {
        min-width: 12px;
        padding: 0;
        background-color: transparent;
        border: none;
        box-shadow: none;
        color: ${c.fg_muted};
      }

      /* sliders: volume / mic / brightness share one look */
      .widget-volume,
      .widget-slider,
      .widget-backlight {
        background-color: ${c.bg_alt};
        border: 1px solid ${c.fg_muted};
        border-radius: 5px;
        padding: 12px 15px;
        margin: 0 15px 15px 15px;
        color: ${c.fg};
      }

      .widget-volume label,
      .widget-slider label,
      .widget-backlight label {
        color: ${c.accent};
        padding-right: 10px;
      }

      .widget-volume trough,
      .widget-slider trough,
      .widget-backlight trough {
        background-color: ${c.bg};
        border: none;
        border-radius: 5px;
        min-height: 8px;
      }

      .widget-volume trough highlight,
      .widget-slider trough highlight,
      .widget-backlight trough highlight {
        background-color: ${c.accent};
        border-radius: 5px;
      }

      .widget-volume slider,
      .widget-slider slider,
      .widget-backlight slider {
        background-color: ${c.fg};
        border-radius: 3px;
        min-width: 14px;
        min-height: 14px;
      }

      /* per-app volume expand button */
      .widget-volume button {
        background-color: transparent;
        border: none;
        color: ${c.fg};
      }

      .widget-volume button:hover {
        color: ${c.accent};
      }

      /* menubar: toggles + dropdowns, styled like wofi entries */
      .widget-menubar {
        margin: 0 15px 15px 15px;
      }

      .widget-menubar button {
        background-color: ${c.bg_alt};
        border: 1px solid ${c.fg_muted};
        border-radius: 5px;
        color: ${c.fg};
        padding: 8px 12px;
        margin: 2px;
        font-size: 16px;
      }

      .widget-menubar button:hover {
        background-color: ${c.fg_muted};
      }

      /* active toggle -> accent (swaync sets .active, not :checked) */
      .widget-menubar button.active {
        background-color: ${c.accent};
        border: 1px solid ${c.accent};
        color: ${c.bg};
      }

      /* dropdown container */
      .widget-menubar > box {
        background-color: transparent;
      }

      /* do not disturb -- square toggle, no round */
      .widget-dnd {
        background-color: ${c.bg_alt};
        padding: 10px 15px;
        border-radius: 5px;
        margin: 0 15px 15px 15px;
        color: ${c.fg};
        border: 1px solid ${c.fg_muted};
      }

      .widget-dnd > switch {
        background-color: ${c.bg};
        border: 1px solid ${c.fg_muted};
        border-radius: 5px;
        box-shadow: none;
        min-width: 42px;
        min-height: 20px;
      }

      .widget-dnd > switch:checked {
        background-color: ${c.accent};
        border: 1px solid ${c.accent};
      }

      .widget-dnd > switch slider {
        background-color: ${c.fg};
        border-radius: 3px;
        box-shadow: none;
        min-width: 16px;
        min-height: 16px;
      }

      .widget-dnd > switch:checked slider {
        background-color: ${c.bg};
      }

      /* notifications -- the wofi "entry" */
      .notification-row {
        outline: none;
        margin: 0 15px 10px 15px;
      }

      .notification {
        background-color: ${c.bg_alt};
        border-radius: 5px;
        border: 1px solid ${c.fg_muted};
      }

      .notification-default-action {
        background-color: transparent;
        padding: 12px;
        border-radius: 5px;
      }

      .notification-default-action:hover {
        background-color: ${c.accent};
      }

      .notification-default-action:hover .summary,
      .notification-default-action:hover .body,
      .notification-default-action:hover .time {
        color: ${c.bg};
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
        background-color: ${c.red};
        border: 1px solid ${c.bg};
      }

      /* text */
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

      /* action buttons */
      .notification-action {
        padding: 6px;
        margin: 4px 4px 0 0;
        box-shadow: none;
        background-color: ${c.bg_alt};
        border: 1px solid ${c.fg_muted};
        color: ${c.fg};
        border-radius: 5px;
      }

      .notification-action:hover {
        background-color: ${c.accent};
        border: 1px solid ${c.accent};
        color: ${c.bg};
      }
    '';
  };
}
