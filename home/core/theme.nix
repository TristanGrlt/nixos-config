{ lib, config, ... }:

let
  palettes = {
    main = {
      accent   = "#ff8a5c";
      bg       = "#141416";
      bg_alt   = "#39393b";
      fg_muted = "#3c3c3e";
      fg       = "#c2c2c2";
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

    fonts = {
      monospace = lib.mkOption {
        type = lib.types.str;
        default = "SpaceMono Nerd Font";
        description = "Default monospace font";
      };
      sansSerif = lib.mkOption {
        type = lib.types.str;
        default = "Space Grotesk";
        description = "Default sans-serif font";
      };
    };
  };

  config = {
    theme.colors = palettes.${config.theme.name};
  };
}
