{ ... }:

{
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;
  hardware.graphics.enable32Bit = true;
  programs.gamescope.enable = true;
}
