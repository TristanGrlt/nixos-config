{ ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Texte
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
      "text/csv" = [ "nvim.desktop" ];

      # Images
      "image/png" = [ "org.gnome.loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.loupe.desktop" ];
      "image/gif" = [ "org.gnome.loupe.desktop" ];
      "image/svg+xml" = [ "org.gnome.loupe.desktop" ];
      "image/webp" = [ "org.gnome.loupe.desktop" ];

      # PDF
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
    };
  };
}
