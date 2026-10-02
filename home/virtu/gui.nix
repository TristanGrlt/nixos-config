{ pkgs, ... }:

{
  home.packages = with pkgs; [
    virt-manager # Graphique
    virt-viewer # SPICE/VNC
    spice-gtk
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
