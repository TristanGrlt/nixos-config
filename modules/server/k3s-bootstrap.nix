{
  config,
  lib,
  inputs,
  ...
}:

with lib;
let
  cfg = config.services.gitops-bootstrap;
in
{
  options.services.gitops-bootstrap = {
    enable = mkEnableOption "ArgoCD GitOps Bootstrap";
    targetPath = mkOption {
      type = types.str;
      default = "bootstrap";
      description = "The name of the bootstrap folder";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.k3s.preStart = ''
      mkdir -p /var/lib/rancher/k3s/server/manifests

      # Copy the manifests from the Nix store to the watch k3s folder
      cp ${inputs.homelab}/${cfg.targetPath}/*.yaml /var/lib/rancher/k3s/server/manifests/
    '';
  };
}
