{
  description = "System Configuration for WSL NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixos-wsl.url = "github:nix-community/NixOS-wsl/main";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-wsl, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ 
        nixos-wsl.nixosModules.default
	{
          system.stateVersion = "25.05";
	  wsl.enable = true;
	}
        ./configuration.nix 
      ];
    };
  };
}
