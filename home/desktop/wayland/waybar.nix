{ config, pkgs, ... }:

let
  c = config.theme.colors;
in
{
  services.playerctld.enable = true;

  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 32;
        spacing = 0;
        margin-top = 4;
        margin-left = 0;
        margin-right = 0;
        
        modules-left = [
          "sway/workspaces"
        ];
        
        modules-center = [
          "mpris"
        ];
        
        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "battery"
          "clock"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          format = "{name}";
        };

        "cpu" = {
          interval = 5;
          format = " {usage}%";
        };

        "memory" = {
          interval = 5;
          format = " {used:0.1f}G";
        };

        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %d %B %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        "network" = {
          format = "{icon}";
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󰀂 Wired";
          format-disconnected = "󰤮 Offline";
          tooltip-format-wifi = "{essid} ({frequency} GHz)";
          interval = 5;
        };

        "battery" = {
          format = "{icon} {capacity}%";
          format-discharging = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
          states = {
            warning = 20;
            critical = 10;
          };
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "swayosd-client --output-volume mute-toggle";
        };

        "mpris" = {
          format = " {dynamic}";
          format-paused = "󰝛 {dynamic}";
          interval = 1;
          max-length = 40;
        };

        "tray" = {
          icon-size = 14;
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        font-family: "SpaceMono Nerd Font", monospace;
        font-size: 13px;
        font-weight: bold;
        border-radius: 5px;
        min-height: 22px;
      }

      window#waybar {
        background-color: ${c.bg};
        color: ${c.fg};
        padding: 0;
        margin: 0;
        border-radius: 0px;
      }

      tooltip {
        background: ${c.bg_alt};
        border: 2px solid ${c.fg_muted};
        border-radius: 8px;
      }
      
      tooltip label {
        color: ${c.fg};
      }

      #workspaces {
        margin: 4px;
        padding: 0;
        background-color: ${c.bg_alt};
      }

      #workspaces button {
        margin: 0;
        padding: 0 8px;
        background-color: transparent;
        color: ${c.fg};
        transition: 0.2s;
      }

      #workspaces button:hover {
        background-color: ${c.fg_muted};
      }

      #workspaces button.focused {
        background-color: ${c.accent};
        color: ${c.bg};
      }

      #window,
      #clock,
      #battery,
      #cpu,
      #memory,
      #mpris,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 12px;
        background-color: ${c.bg_alt};
        color: ${c.fg};
        margin: 4px 4px 4px 0;
      }

      #network.disconnected,
      #pulseaudio.muted {
        color: ${c.accent};
      }

      @keyframes blink {
        to {
          background-color: ${c.fg};
          color: ${c.bg};
        }
      }

      #battery.critical:not(.charging) {
        background-color: ${c.red};
        color: ${c.fg};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
    '';
  };
}
