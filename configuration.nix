{ config, lib, pkgs, inputs, ... }:

{
  imports = [  ];
  
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  wsl.defaultUser = "me";

  system.stateVersion = "25.05"; 

  environment.systemPackages = with pkgs; [
    ripgrep
    eza
    lazygit
    oh-my-zsh
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
}
