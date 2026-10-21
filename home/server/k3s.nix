{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl
    kubernetes-helm
    cmctl
  ];

  programs.zsh.shellAliases = {
    k = "kubectl";
  };

  sops.secrets.kubeconfig = {
    sopsFile = ../../secrets/kubeconfig.yaml;
    format = "yaml";
    path = "${config.home.homeDirectory}/.kube/config";
    mode = "0600";
    key = "";
  };
}
