{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { ... }:
    {
      nixosModules.default = (
        { ... }:
        {
          imports = [
            ./modules/sing.nix
          ];
        }
      );
    };
}
