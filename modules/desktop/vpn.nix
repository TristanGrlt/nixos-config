{ ... }:

{
  # disable integrity_test to be able to use the DPI vpn
  environment.etc."strongswan.conf".text = ''
    libstrongswan {
      integrity_test = no
    }
  '';
}
