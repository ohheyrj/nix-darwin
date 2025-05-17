{ config, pkgs, ... }:

{
  home = {
    username = "richard";
    stateVersion = "24.11";
    homeDirectory = /Users/richard;
  };
  programs = {
    home-manager.enable = true;
    eza = {
      enable = true;
      enableZshIntegration = true;
      colors = "auto";
      icons = "auto";
    };
    lazygit = {
      enable = true;
      settings = {
        gui.nerdFontVersion = "3";
        gui.showIcons = true;
      };
    };
  };
  imports = import ./home-manager;
}
