{
  description = "System Configuration for WSL NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixos-wsl.url = "github:nix-community/NixOS-wsl/main";
    nix-auth.url = "github:numtide/nix-auth";
    expert.url = "github:elixir-lang/expert";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs; };
        modules = [ 
        inputs.nixos-wsl.nixosModules.default {
            system.stateVersion = "25.05";
	        wsl.enable = true;
	    }
        ./configuration.nix 
      ];
    };
  };
}
