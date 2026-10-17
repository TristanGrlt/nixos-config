{ ... }: {
  sops = {
    defaultSopsFile = ../../secrets/shared.yaml;
    age.keyFile = "/var/lib/sops-nix/keys.txt";
  };
}
