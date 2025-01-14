{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        up = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/up ];
          specialArgs = { inherit inputs outputs; };
        };
        down = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/down
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
        "khp@up" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/khp/up.nix ];
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "khp@down" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/khp/down.nix ];
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "khp@muon" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/khp/muon.nix ];
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
}
