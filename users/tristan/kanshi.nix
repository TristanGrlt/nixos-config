{ pkgs, ... }:

{
  services.kanshi = {
    enable = true;
    
    settings = [
      {
        profile = {
          name = "nomade";
          outputs = [
            { 
              criteria = "eDP-1"; # Ton laptop garde généralement ce nom
              status = "enable"; 
            }
          ];
        };
      }
      {
        profile = {
          name = "home";
          outputs = [
            { 
              criteria = "eDP-1"; 
              position = "206,1202";
              scale = 1.10;
            }
            { 
              criteria = "Dell Inc. DELL U2424H HNJJL04"; 
              status = "enable";
              scale = 0.90;
              position = "0,0";
              mode = "1920x1080@120Hz";
            }
          ];
        };
      }
    ];
  };
}
