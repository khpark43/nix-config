{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nix-darwin.url = "github:LnL7/nix-darwin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    nixvim.url = "github:khpark43/nixvim-config";
    nvf.url = "github:khpark43/nvf-config";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      # nixpkgs-stable,
      home-manager,
      # systems?
      nixos-wsl,
      nix-darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/nixos ];
          specialArgs = { inherit inputs outputs; };
        };
        ng = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/ng
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };
      darwinConfigurations = {
        muon = nix-darwin.lib.darwinSystem {
          modules = [ ./hosts/muon ];
          specialArgs = { inherit inputs outputs; };
        };
      };
      homeConfigurations = {
        "khp@nixos" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/khp ];
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "khp@ng" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/khp/ng.nix ];
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "khp@muon" = home-manager.lib.homeManagerConfiguration {
          modules = [./home/khp/muon.nix];
          pkgs = import nixpkgs { system = "aarch64-darwin"; config.allowUnfree = true; };
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
  }
