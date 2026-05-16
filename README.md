# nix-sing

A nixos module for managing (docker/podman) compose stacks declaratively.

## Example

An example configuration for hosting oauth2-proxy with agenix secret management:

```nix
compose.stacks = {
  "oauth2-proxy" = {
    "oauth2-proxy" = {
      image = "quay.io/oauth2-proxy/oauth2-proxy:v7.14.2";
      cmd = [
        "--config"
        "/oauth2-proxy.cfg"
      ];
      environmentFiles = [
        config.age.secrets.madoka-oauth2-proxy-environment.path
      ];
      user = "2002:2002";
      volumes = [
        "${configFile}:/oauth2-proxy.cfg:ro"
        "${./error.html}:/templates/error.html"
        "${config.age.secrets.madoka-oauth2-proxy-cookie-secret.path}:/cookie_secret:ro"
      ];
      network."tailnet" = {};
      dependsOn = [
        "tailscale"
      ];
    };
  };
};

compose.networks = {
  "tailnet" = {
    ipam = {
      subnet = "172.20.0.0/24";
      gateway = "172.20.0.1";
    };
  };
};

virtualisation.podman = {
  enable = true;
  autoPrune.enable = true;
  dockerCompat = true;
};
virtualisation.oci-containers.backend = "podman";
```
