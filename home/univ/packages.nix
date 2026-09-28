{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sqlcl
    oracle-instantclient
  ];
}
