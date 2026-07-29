{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    
    settings.alias = {
      st = "status";
      co = "checkout";
      sw = "switch";
      br = "branch";
      ci = "commit";
      ca = "commit --amend --no-edit";
      cm = "commit -m";
      lg = "log --oneline --graph --all --decorate";
      ll = "log --oneline -15";
      last = "log -1 HEAD --stat";
      df = "diff";
      ds = "diff --staged";
      ss = "stash";
      sp = "stash pop";

      cz = "!cz commit";
    };
  };

  home.packages = with pkgs; [
    (commitizen.overridePythonAttrs (old: {
      doCheck = false;
    }))
  ];
}
