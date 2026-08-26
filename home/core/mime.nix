{ pkgs, ... }:

let
  images = [ "org.gnome.loupe.desktop" ];
  texte = [ "nvim.desktop" ];
  pdf = [ "org.gnome.Evince.desktop" ];
  dossier = [ "thunar.desktop" ];

  mimeMap = {
    "inode/directory" = dossier;

    "text/plain" = texte;
    "text/markdown" = texte;
    "text/csv" = texte;

    "image/png" = images;
    "image/jpeg" = images;
    "image/jpg" = images;
    "image/gif" = images;
    "image/svg+xml" = images;
    "image/webp" = images;

    "application/pdf" = pdf;
  };
in
{
  home.packages = [ pkgs.xdg-utils ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = mimeMap;
    associations.added = mimeMap;
  };
}
