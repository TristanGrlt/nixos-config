{
  config,
  pkgs,
  username,
  ...
}:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
  };

  #  environment.systemPackages = with pkgs; [
  #    (where-is-my-sddm-theme.override {
  #      themeConfig.General = {
  #        background = "${config.home-manager.users.${username}.theme.wallpaper}";
  #        backgroundMode = "fill";
  #
  #        showUsersByDefault = true;
  #        showSessionsByDefault = true;
  #        passwordMask = true;
  #
  #        passwordFontSize = "20";
  #        usersFontSize = "12";
  #        sessionsFontSize = "10";
  #      };
  #    })
  #  ];
}
