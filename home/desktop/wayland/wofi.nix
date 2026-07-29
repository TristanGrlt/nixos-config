{ config, ... }:

let
  c = config.theme.colors;
  f = config.theme.fonts;
in
{
  programs.wofi = {
    enable = true;
    settings = {
      location = "center";
      allow_markup = true;
      width = 350;
    };
    style = ''
      * {
        font-family: "${f.monospace}", monospace;
        font-weight: bold;
        font-size: 14px;
      }
      
      window {
        background-color: ${c.bg};
        color: ${c.fg};
        border: 3px solid ${c.bg_alt};
        border-radius: 10px;
      }
      
      #input {
        background-color: ${c.bg_alt};
        color: ${c.fg};
        border: 2px solid ${c.fg_muted};
        border-radius: 5px;
        margin: 15px 15px 10px 15px;
        padding: 8px;
      }
      
      #scroll {
        margin: 5px 0px 15px 0px;
      }
      
      #entry {
        background-color: ${c.bg_alt};
        padding: 8px 12px;
        margin: 4px 15px;
        border-radius: 5px;
        border: 1px solid ${c.fg_muted};
      }
      
      #text {
        color: ${c.fg};
      }
      
      #entry:selected {
        background-color: ${c.accent};
        border: 1px solid ${c.accent};
      }
      
      #text:selected {
        color: ${c.bg};
      }
    '';
  };
}
