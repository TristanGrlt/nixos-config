{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-tools
    google-java-format
    black
    prettier
  ];
}
