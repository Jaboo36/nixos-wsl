{ config, lib, pkgs, inputs, ... }:

{
  imports = [  ];
  
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  wsl.defaultUser = "me";

  system.stateVersion = "25.05"; 

  environment.systemPackages = with pkgs; [
    beam28Packages.erlang
    beam28Packages.elixir_1_19
    docker
    eza
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

  programs.neovim.enable = true;

  programs.git.enable = true;

  programs.direnv.enable = true;
}
