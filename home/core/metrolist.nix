{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.metrolist.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
