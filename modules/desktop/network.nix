{ pkgs, config, ... }:
{
  sops.secrets."wifi/home_psk" = { };
  sops.secrets."wifi/eduroam_pwd" = { };
  sops.secrets."vpn/dpi_pwd" = { };

  sops.templates."nm-wifi.env".content = ''
    PSK_HOME=${config.sops.placeholder."wifi/home_psk"}
    PWD_EDUROAM=${config.sops.placeholder."wifi/eduroam_pwd"}
    PWD_VPN_DPI=${config.sops.placeholder."vpn/dpi_pwd"}
  '';

  networking.networkmanager.ensureProfiles.environmentFiles = [
    config.sops.templates."nm-wifi.env".path
  ];

  networking.networkmanager.wifi.macAddress = "random";

  services.strongswan.enable = true;
  networking.networkmanager.plugins = [ pkgs.networkmanager-l2tp ];

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
    #####
    # VPN DPI
    #####
    "VPN_DPT_INFO" = {
      connection = {
        id = "VPN DPT INFO";
        type = "vpn";
      };
      vpn = {
        service-type = "org.freedesktop.NetworkManager.l2tp";
        gateway = "srv-dpi-vpn.univ-rouen.fr";
        user = "groultri";
        password-flags = "0";
        ipsec-enabled = "yes";
        ipsec-psk = "ZqYP3Dmex09aqc0UIJ0I";
        ipsec-ike = "aes256-sha1-modp2048!";
        ipsec-esp = "aes128-sha1!";
      };
      vpn-secrets = {
        password = "$PWD_VPN_DPI";
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
