{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    nixvim.url = "github:khpark43/nixvim-config";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    # nixpkgs-stable,
    home-manager,
    # systems?
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x84_64-linux";
        modules = [./hosts/nixos];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };
    homeConfigurations = {
      khp = home-manager.lib.homeManagerConfiguration {
        modules = [./home/khp];
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
	extraSpecialArgs = {
	  inherit inputs outputs;
	};
      };
    };
  };
}
