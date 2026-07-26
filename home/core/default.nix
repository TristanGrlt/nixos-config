{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    commitizen
  ];

  programs.firefox.enable = true;
}
