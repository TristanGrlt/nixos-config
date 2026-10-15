{ pkgs, ... }:
{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtlSsh = 7200; # 12h
    maxCacheTtlSsh = 7200;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
