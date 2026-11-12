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
    ../../home/server/k3s.nix

    ./kanshi.nix
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
        IdentityFile = "~/.ssh/git_tristanGrlt";
      };
    };
  };

  programs.git = {
    settings = {
      user = {
        name = "TristanGrlt";
        email = "tristan.groult@gmail.com";
      };
      gpg.format = "ssh";
      commit.gpgsign = true;
    };
    signing = {
      key = "~/.ssh/git_tristanGrlt.pub";
      signByDefault = true;
    };
    includes = [
      {
        condition = "hasconfig:remote.*.url:*gitlab-dpt-info-sciences.univ-rouen.fr*/**";
        contents = {
          user = {
            name = "groultri";
            email = "tristan.groult@univ-rouen.fr";
          };
        };
      }
    ];
  };

  home.stateVersion = "26.05";
}
