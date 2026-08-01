{ config, pkgs, ... }:

{
  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  
  programs.git = {
    settings.user = {
      name = "TristanGrlt";
      email = "tristan.groult@gmail.com";
    };
  };
  theme.name = "main";
  theme.wallpaper = ../../wallpapers/anna-scarfiello-Pxf5syDVuxQ.jpg;

}
