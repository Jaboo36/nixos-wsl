{ config, lib, pkgs, inputs, ... }:

{
    imports = [  ];
  
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
    wsl.defaultUser = "me";

    system.stateVersion = "25.05"; 

    environment.systemPackages = with pkgs; [
        eza
        gcc
        inotify-tools
        inputs.expert.packages.${stdenv.hostPlatform.system}.default
        inputs.nix-auth.packages.${stdenv.hostPlatform.system}.default
        lazygit
        lua-language-server
        ripgrep
        starship
        tree-sitter
        (inputs.yazi.packages.${stdenv.hostPlatform.system}.default.override {
        _7zz = pkgs._7zz-rar;
        })
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
