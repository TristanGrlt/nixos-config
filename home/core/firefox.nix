{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    # System-wide policies
    policies = {
      # Disable the built-in password manager
      PasswordManagerEnabled = false;
      # Disable the first-run welcome screen
      OverrideFirstRunPage = "";
      # Disable Firefox Sync and Pocket
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableTelemetry = true;
    };

    profiles.tristan = {
      id = 0; # Set this profile as the absolute default
      isDefault = true;

      search = {
        force = true;
        default = "google";

        # Engine
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "bing".metaData.hidden = true;
          "ebay".metaData.hidden = true;
        };
      };

      settings = {
        # Auto-enable extensions installed by Nix
        "extensions.autoDisableScopes" = 0;

        # Force dark theme
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.content-theme" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        # Disable start/welcome page
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage" = "about:blank";

        # Disable new tab clutter
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        # Extra precaution for password manager
        "signon.rememberSignons" = false;
      };

      # Extensions
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        darkreader
        betterttv
        enhancer-for-youtube
        return-youtube-dislikes
        sponsorblock
        videospeed
        behind-the-overlay-revival
        imagus
        youtube-no-translation
        purpleadblock
        multi-account-containers
      ];
    };
  };
}
