{ config, pkgs, ... }:

{
  imports = [
    ../../home/core/default.nix
    ../../home/desktop/core/default.nix 
    ../../home/desktop/wayland/default.nix 
    ../../home/desktop/wayland/sway/default.nix
  ];
}
