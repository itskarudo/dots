{
  description = "my configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      treefmt-nix,
      ...
    }:
    let
      inherit (self) outputs;
      mylib = import ./lib { inherit inputs outputs; };

      # only hera currently
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
      ];

      treefmtEval = forAllSystems (
        system: treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix
      );
    in
    {
      formatter = forAllSystems (system: treefmtEval.${system}.config.build.wrapper);

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            name = "nix-dev";

            packages = with pkgs; [
              deadnix
              just
              nh
              nixd
              nixfmt
              statix
            ];
          };
        }
      );

      darwinConfigurations.hera = mylib.mkDarwin {
        hostname = "hera";
        username = "karu";
        system = "aarch64-darwin";
      };
    };
}
