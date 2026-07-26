{ pkgs, ... }:

{
  # UI style config
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      show-failed-attempts = true;
      indicator-caps-lock = true;
    };
  };

  # Auto activation config
  services.swayidle = {
    enable = true;
    
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f -c 000000"; }
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -f -c 000000"; }
    ];
    
    timeouts = [
      { 
        timeout = 300; # 5 mins 
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000"; 
      }
      { 
        timeout = 600; # 10 mins 
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'"; 
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'"; 
      }
    ];
  };
}
