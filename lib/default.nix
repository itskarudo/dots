{ inputs, outputs }:
let
  inherit (inputs)
    nix-darwin
    home-manager
    mac-app-util
    nix-homebrew
    ;

  brewModule = username: {
    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = username;
    };
  };

  hmModule = username: hostname: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = false;
      backupFileExtension = "bak";
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          username
          hostname
          ;
      };
      sharedModules = [
        mac-app-util.homeManagerModules.default
      ];
      users.${username}.imports = [
        ../modules/hm
        ../modules/shell
      ];
    };
  };

in
{
  mkDarwin =
    {
      hostname,
      username,
      system,
    }:
    nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit
          inputs
          outputs
          username
          hostname
          ;
      };
      modules = [
        { nixpkgs.hostPlatform = system; }
        ../modules/system
        inputs.mac-app-util.darwinModules.default
        home-manager.darwinModules.home-manager
        (hmModule username hostname)
        nix-homebrew.darwinModules.nix-homebrew
        (brewModule username)
      ];
    };
}
