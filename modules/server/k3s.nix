{
  config,
  pkgs,
  ...
}:

{
  sops.secrets."k3s-token" = {
    sopsFile = ../../secrets/k3s.yaml;
    format = "yaml";
  };

  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = config.sops.secrets."k3s-token".path;

    extraFlags = toString [
      "--disable traefik"
      "--disable servicelb"
      "--flannel-backend=wireguard-native"
    ];
  };

  environment.systemPackages = with pkgs; [
    k3s
    kubectl
    kubernetes-helm
  ];

  networking.firewall.allowedTCPPorts = [
    6443 # k3s API server
    10250 # Kubelet metrics
  ];
  networking.firewall.allowedUDPPorts = [
    8472 # Flannel VXLAN
    51820 # WireGuard
    51821 # WireGuard
  ];
}
