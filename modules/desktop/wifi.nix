{ config, ... }:
{
  sops.secrets."wifi/home_psk" = { };
  sops.secrets."wifi/eduroam_pwd" = { };

  sops.templates."nm-wifi.env".content = ''
    PSK_HOME=${config.sops.placeholder."wifi/home_psk"}
    PWD_EDUROAM=${config.sops.placeholder."wifi/eduroam_pwd"}
  '';

  networking.networkmanager.ensureProfiles.environmentFiles = [
    config.sops.templates."nm-wifi.env".path
  ];

  networking.networkmanager.wifi.macAddress = "random";

  networking.networkmanager.ensureProfiles.profiles = {
    #####
    # Home_Network
    #####
    "Home_Network" = {
      connection = {
        id = "Home_Network";
        type = "wifi";
        autoconnect = true;
      };
      wifi = {
        ssid = "Livebox-F43C";
        mode = "infrastructure";
        cloned-mac-address = "permanent";
      };
      wifi-security = {
        key-mgmt = "wpa-psk";
        psk = "$PSK_HOME";
      };
      ipv4 = {
        method = "auto";
      };
      ipv6 = {
        method = "auto";
      };
    };
    #####
    # Eduroam
    #####
    "Eduroam" = {
      connection = {
        id = "Eduroam";
        type = "wifi";
      };
      wifi = {
        ssid = "eduroam";
        mode = "infrastructure";
      };
      wifi-security = {
        key-mgmt = "wpa-eap";
      };
      "802-1x" = {
        eap = "peap;";
        identity = "groultri";
        password = "$PWD_EDUROAM";
        phase2-auth = "mschapv2";
      };
      ipv4 = {
        method = "auto";
      };
      ipv6 = {
        method = "auto";
      };
    };
  };
}
