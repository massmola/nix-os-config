{
  description = "spatola's config";

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {

      # NixOS Configuration
      nixosConfigurations.marvin = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        
        specialArgs = { 
          inherit inputs;
        };

        modules = [
          # Name of the host
          { networking.hostName = "marvin"; }

          # Main configuration file for NixOS
          ./conf/configuration.nix

          # User configuration with home-manager
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Personal User Configuration
            home-manager.users.spatola = import ./home/spatola.nix;

            # Work User Configuration
            home-manager.users.ict = import ./home/ict.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
            home-manager.extraSpecialArgs = { 
              inherit inputs;
            };
          }
        ];
      };
    };

  inputs = {

    # Unstable Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Maintained packaging for the ChatGPT Linux desktop app.
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
