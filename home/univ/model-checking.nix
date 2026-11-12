{ pkgs, ... }:
{
  home.packages = with pkgs; [
    spin
  ];
}
