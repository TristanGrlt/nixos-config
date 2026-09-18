{ config, pkgs, ... }:
let
  c = config.theme.colors;
  f = config.theme.fonts;
in
{
  home.packages = [ pkgs.vesktop ];

  xdg.configFile."vesktop/settings/settings.json".text = builtins.toJSON {
    discordBranch = "stable";
    firstLaunch = false;
    arRPC = "on";
    splashColor = "${c.accent}";
    splashBackground = "${c.bg}";
    enableMenu = false;
    minimizeToTray = true;
  };

  xdg.configFile."vesktop/themes/nix-theme.theme.css".text = ''
    /**
     * @name NixOS Auto Theme
     * @description dynamic theme
     */
    :root {
      --background-primary: ${c.bg};
      --background-secondary: ${c.bg_alt};
      --background-secondary-alt: ${c.bg};
      --background-tertiary: ${c.bg};
      --text-normal: ${c.fg};
      --text-muted: ${c.fg_muted};
      --brand-experiment: ${c.accent};
      --header-primary: ${c.accent};
      --font-primary: "${f.sansSerif}", sans-serif;
      --font-display: "${f.monospace}", monospace;
    }
  '';
}
