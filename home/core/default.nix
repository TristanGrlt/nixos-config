{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (commitizen.overridePythonAttrs (old: {
      doCheck = false;
    }))
  ];

  programs.firefox.enable = true;
}
