{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    # systems?
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x64_64-linux";
        modules = [./hosts/nixos];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };
    homeConfigurations = {
      khp = home-manager.lib.homeManagerConfiguration {
        modules = [./home/khp];
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
	extraSpecialArgs = {
	  inherit inputs outputs;
	};
      };
    };
  };
}
