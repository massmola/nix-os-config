{
  description = "spatola's config";

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    
    user = {
      username = "spatola";
      description = "Spatola";
    };

  in {
    
    nixosConfigurations.marvin = nixpkgs.lib.nixosSystem {
      
      system = "x86_64-linux";

      modules =
        [
          {networking.hostName = "marvin";}
          ./conf
          inputs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.spatola = import ./home/home-spatola.nix;
            home-manager.users.ict = import ./home/home-ict.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      
      specialArgs = {
        inherit inputs;
        inherit user;
      };
    };
  };

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    
  };
}
