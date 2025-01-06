{
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = ../secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/khp/.config/sops/age/keys.txt";
    secrets = {
      example-key = {};
      "myservice/my_subdir/my_secret" = {};
    };
  };
}
