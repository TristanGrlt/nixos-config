{ lib, ... }:

{
  options.theme.wallpaper = lib.mkOption {
    type = lib.types.path;
    description = "Path to the user specific wallpaper image";
  };
}
