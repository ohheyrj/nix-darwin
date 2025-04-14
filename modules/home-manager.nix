{ config, pkgs, ... }:

{
  home.username = "richard";
  home.stateVersion = "24.11";
  home.sessionVariables = {
      TEST_ENV = "hello";
    };
  home.homeDirectory = /Users/richard;
  programs.home-manager.enable = true;
}
