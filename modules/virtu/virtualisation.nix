################################################################################
# Module:       Virtualisation
# Description:  Enable libvirt virtualisation tools
# In:           To use it, the user must be in the kvm and libvirtd group
# Out:          quemu, libvirt and libvirtd enable on the host
# Ref:          gui et cli tools availabe in the home directory
################################################################################
{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };

  environment.systemPackages = with pkgs; [
    qemu
    libvirt
  ];

  programs.dconf.enable = true;
}
