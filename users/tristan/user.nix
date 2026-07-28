{ config, pkgs, ... }:

{
  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  
  programs.git = {
    userName = "TristanGrlt";
    userEmail = "tristan.groult@gmail.com";
  };
  theme.name = "main";

}
