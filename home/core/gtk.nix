{ config, pkgs, ... }:

let
  c = config.theme.colors;
  
  # Le code CSS qui surcharge les couleurs internes de GTK
  customGtkCss = ''
    @define-color accent_color ${c.accent};
    @define-color accent_bg_color ${c.accent};
    @define-color accent_fg_color ${c.bg};
    
    @define-color window_bg_color ${c.bg};
    @define-color window_fg_color ${c.fg};
    
    @define-color view_bg_color ${c.bg};
    @define-color view_fg_color ${c.fg};
    
    @define-color headerbar_bg_color ${c.bg_alt};
    @define-color headerbar_fg_color ${c.fg};
    
    @define-color popover_bg_color ${c.bg_alt};
    @define-color popover_fg_color ${c.fg};
    
    @define-color card_bg_color ${c.bg_alt};
    @define-color card_fg_color ${c.fg};
    
    @define-color dialog_bg_color ${c.bg};
    @define-color dialog_fg_color ${c.fg};
  '';
in
{
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      # adw-gtk3 reproduit l'apparence moderne de GNOME pour les vieilles apps GTK3
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # On demande à Qt (KDE, VLC, etc.) de copier l'apparence de GTK
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  # On injecte notre CSS dans les dossiers de configuration de GTK3 et GTK4
  xdg.configFile = {
    "gtk-3.0/gtk.css".text = customGtkCss;
    "gtk-4.0/gtk.css".text = customGtkCss;
  };
}
