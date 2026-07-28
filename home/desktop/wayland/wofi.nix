{ config, ... }:

let
  c = config.theme.colors;
in
{
  programs.wofi = {
    enable = true;
    settings = {
      location = "center";
      allow_markup = true;
      width = 350; # Un peu plus large pour que les "blocs" respirent
    };

    # --- STYLE RETRO / BLOCKS ---
    style = ''
      * {
        font-family: "SpaceMono Nerd Font", monospace;
        font-weight: bold;
        font-size: 14px;
      }
      
      /* La fenêtre principale (Fond global Onyx) */
      window {
        background-color: ${c.bg};
        color: ${c.fg};
        border: 3px solid ${c.bg_alt};
        border-radius: 10px;
      }
      
      /* La barre de recherche (Graphite avec bordure Gunmetal) */
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
      
      /* Chaque ligne d'application devient un bloc (comme les modules Waybar) */
      #entry {
        background-color: ${c.bg_alt};
        padding: 8px 12px;
        margin: 4px 15px;
        border-radius: 5px;
        border: 1px solid ${c.fg_muted};
      }
      
      /* Le texte par défaut (Cool Steel) */
      #text {
        color: ${c.fg};
      }
      
      /* Le bloc sélectionné (Fond Tangerine Dream) */
      #entry:selected {
        background-color: ${c.accent};
        border: 1px solid ${c.accent};
      }
      
      /* Le texte du bloc sélectionné (Contraste fort : fond orange / texte noir) */
      #text:selected {
        color: ${c.bg};
      }
    '';
  };
}
