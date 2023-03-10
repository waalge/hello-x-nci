{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nci.url = "github:yusdacra/nix-cargo-integration/919017ea66b17f20df6c5721aacdbcb5e35924f1";
  inputs.nci.inputs.nixpkgs.follows = "nixpkgs";
  inputs.parts.url = "github:hercules-ci/flake-parts";
  inputs.parts.inputs.nixpkgs-lib.follows = "nixpkgs";

  outputs = inputs @ {
    parts,
    nci,
    ...
  }:
    parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [nci.flakeModule];
      perSystem = {...}: {
        # declare project
        nci.projects."my-project" = {};
        # configure crates
        nci.crates."hello-x" = {
          # export crate (packages and devshell) in flake outputs
          export = true;
          # look at docs for more options
        };
      };
    };
}
