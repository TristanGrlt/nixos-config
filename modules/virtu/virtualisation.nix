{ pkgs, username, ... }:

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

  users.users.${username}.extraGroups = [
    "libvirtd"
    "kvm"
  ];

  environment.systemPackages = with pkgs; [
    qemu
    libvirt
  ];

  programs.dconf.enable = true;
}
