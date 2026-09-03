{
  config,
  pkgs,
  username,
  ...
}:
let
  blurredWallpaper =
    pkgs.runCommand "blurred-wallpaper.jpg"
      {
        nativeBuildInputs = [ pkgs.imagemagick ];
      }
      ''
        magick ${config.home-manager.users.${username}.theme.wallpaper} -blur 0x24 $out
      '';
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
    extraPackages = with pkgs; [
      qt6.qt5compat
    ];
  };

  environment.systemPackages = with pkgs; [
    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${blurredWallpaper}";
        backgroundMode = "fill";

        passwordInputBackground = "#ffffff";
        passwordTextColor = "#000000";
        passwordInputWidth = 0.25;
        passwordInputRadius = 5;
        showUsersByDefault = true;
        showSessionsByDefault = true;
        passwordMask = true;
        passwordFontSize = "20";
        usersFontSize = "12";
        sessionsFontSize = "10";
      };
    })
  ];
}
