{ ... }:

{
  imports = [
    ../../home/core/default.nix
    ../../home/desktop/core/default.nix
    ../../home/desktop/wayland/default.nix
    ../../home/desktop/wayland/sway/default.nix
    ../../home/games/default.nix
    ../../home/univ/default.nix
    ../../home/virtu/default.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";

  theme.name = "main";
  theme.wallpaper = ../../wallpapers/anna-scarfiello-Pxf5syDVuxQ.jpg;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      "github.com" = {
        IdentityFile = "~/.ssh/git_tristanGrlt";
      };
    };
  };

  programs.git = {
    settings.user = {
      name = "TristanGrlt";
      email = "tristan.groult@gmail.com";
    };
  };

  home.stateVersion = "26.05";
}
