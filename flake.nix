{
  description = "System Configuration for WSL NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixos-wsl.url = "github:nix-community/NixOS-wsl/main";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
        system = "x86_64-linux";
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ 
        inputs.nixos-wsl.nixosModules.default {
          system.stateVersion = "25.05";
	  wsl.enable = true;
	}
        ./configuration.nix 
      ];
    };
    devShells.${system}.elixir = let
        pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell {
        packages = with pkgs; [
            beam28Packages.erlang
            beam28Packages.elixir_1_19
            zsh
        ];
        shellHook = ''
            echo "Entering Elixir dev shell"
            echo "Erlang 'erlang --version'"
            echo "Elixir 'elixir --version'"
            exec zsh
        '';
    };
  };
}
