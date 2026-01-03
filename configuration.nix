{ config, lib, pkgs, inputs, ... }:

{
    imports = [  ];
  
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
    wsl.defaultUser = "me";

    system.stateVersion = "25.05"; 

    environment.systemPackages = with pkgs; [
        bat
        eza
        gcc
        inputs.helix.packages.${stdenv.hostPlatform.system}.default
        inotify-tools
        inputs.nix-auth.packages.${stdenv.hostPlatform.system}.default
        lazygit
        lua-language-server
        nixd
        ripgrep
        starship
        tree-sitter
        tree-sitter-grammars.tree-sitter-nix
        (inputs.yazi.packages.${stdenv.hostPlatform.system}.default.override {
        _7zz = pkgs._7zz-rar;
        })
        zellij
    ];

    programs.zsh = {
        enable = true;
    };
    users.defaultUserShell = pkgs.zsh;

    users.users.me.extraGroups = [ "docker" ];

    virtualisation.docker.enable = true;

    programs.neovim.enable = true;

    programs.git.enable = true;

    programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        settings = {
            global = {
                hide_env_diff = true;
            };
        };
    };
}
