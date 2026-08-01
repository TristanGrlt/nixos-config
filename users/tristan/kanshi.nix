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
              position = "0,301";
              scale = 0.90;
            }
            { 
              criteria = "Dell Inc. DELL U2424H HNJJL04"; 
              status = "enable";
              scale = 0.80;
              position = "2137,154";
              mode = "1920x1080@120Hz";
            }
          ];
        };
      }
    ];
  };
}
