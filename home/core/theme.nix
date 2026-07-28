{ lib, config, ... }:

let
  # Définition de ta palette unique
  palettes = {
    main = {
      accent   = "#ff8a5c"; # 1. Tangerine Dream
      bg       = "#141416"; # 2. Onyx
      bg_alt   = "#39393b"; # 3. Graphite (secondary BG off)
      fg_muted = "#3c3c3e"; # 4. Gunmetal (Texte muted)
      fg       = "#c2c2c2"; # 5. Cool Steel (Texte)

      green    = "#5cff8d";
      yellow   = "#ffdc5c";
      blue     = "#5c82ff";
      magenta  = "#a35cff";
      cyan     = "#5cf4ff";
      white    = "#c2c2c2";
      red      = "#ff5c5c";
    };
  };
in
{
  options.theme = {
    name = lib.mkOption {
      type = lib.types.enum (builtins.attrNames palettes);
      default = "main";
      description = "The name of the theme to use";
    };
    
    colors = lib.mkOption {
      type = lib.types.attrs;
      description = "Resolved colors";
    };
  };

  config = {
    theme.colors = palettes.${config.theme.name};
  };
}
