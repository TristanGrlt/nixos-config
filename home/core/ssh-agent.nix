{ pkgs, ... }:
{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtlSsh = 43200; # 12h
    maxCacheTtlSsh = 43200;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
