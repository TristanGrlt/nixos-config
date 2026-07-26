{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      space-grotesk
      nerd-fonts.space-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Space Grotesk" "sans-serif" ];
        monospace = [ "SpaceMono Nerd Font" "monospace" ];
      };
    };
  };
}
