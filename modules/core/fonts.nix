{ pkgs, ... }:

let
  space-grotesk = pkgs.stdenvNoCC.mkDerivation {
    name = "space-grotesk";
    dontConfigure = true;
    src = pkgs.fetchzip {
      url = "https://github.com/floriankarsten/space-grotesk/releases/download/2.0.0/SpaceGrotesk-2.0.0.zip";
      stripRoot = false;
      # Force une erreur pour exposer le hash SRI
      hash = "sha256-niwd5E3rJdGmoyIFdNcK5M9A9P2rCbpsyZCl7CDv7I8=";
    };
    installPhase = ''
      mkdir -p $out/share/fonts/opentype
      find $src -name "*.otf" -exec cp {} $out/share/fonts/opentype/ \;
    '';
  };
in
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
