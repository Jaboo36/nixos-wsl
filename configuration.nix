{ config, lib, pkgs, inputs, ... }:

{
    imports = [  ];
  
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
    wsl.defaultUser = "me";

    system.stateVersion = "25.05"; 

    environment.systemPackages = with pkgs; [
        eza
        inotify-tools
        inputs.nix-auth.packages.${stdenv.hostPlatform.system}.default
        lazygit
        oh-my-zsh
        ripgrep
        starship
        (inputs.yazi.packages.${stdenv.hostPlatform.system}.default.override {
        _7zz = pkgs._7zz-rar;
        })
    ];

    programs.zsh = {
        enable = true;
        ohMyZsh = {
        enable = true;
        };
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
