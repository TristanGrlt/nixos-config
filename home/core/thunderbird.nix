{ config, ... }:

{
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;
    secrets."emails/university_pwd" = { };
  };

  programs.thunderbird = {
    enable = true;
    profiles.tristan = {
      isDefault = true;
      settings = {
        "ui.systemUsesDarkTheme" = 1;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        "mail.uidensity" = 1;
        "mail.pane_config.dynamic" = 2;
        "mailnews.default_view_flags" = 1;
        "mailnews.start_page.enabled" = false;
        "mailnews.start_page.url" = "";

        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "app.shield.optoutbatches" = true;
      };
    };
  };

  accounts.email.accounts = {
    "University" = {
      primary = true;
      realName = "Tristan";
      address = "tristan.groult@univ-rouen.fr";
      userName = "groultri";

      passwordCommand = "cat ${config.sops.secrets."emails/university_pwd".path}";

      imap = {
        host = "imap.univ-rouen.fr";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.univ-rouen.fr";
        port = 465;
        tls.enable = true;
      };

      thunderbird = {
        enable = true;
        profiles = [ "tristan" ];
      };
    };
  };
}
