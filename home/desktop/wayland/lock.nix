{ pkgs, ... }:

{
  programs.hyprlock.enable = true;

  # Auto activation config
  services.swayidle = {
    enable = true;
    
    events = [
      { event = "before-sleep"; command = "${pkgs.hyprlock}/bin/hyprlock"; }
      { event = "lock"; command = "${pkgs.hyprlock}/bin/hyprlock"; }
    ];
    
    timeouts = [
      { 
        timeout = 300; 
        command = "${pkgs.hyprlock}/bin/hyprlock"; 
      }
      { 
        timeout = 600; 
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'"; 
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'"; 
      }
    ];
  };
}
