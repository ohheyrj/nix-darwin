{ config, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.sessionVariables = {
      TEST_ENV = "hello";
    };
  home.homeDirectory = "/Users/richard/";
  programs.home-manager.enable = true;
}
