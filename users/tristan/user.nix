{ config, pkgs, ... }:

{
  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  
  programs.git = {
    userName = "TristanGrlt";
    userEmail = "tristan.groult@gmail.com";
  };
  theme.name = "main";
  theme.wallpaper = ../../wallpapers/anna-scarfiello-Pxf5syDVuxQ.jpg;

}
