{ config, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.sessionVariables = {
      TEST_ENV = "hello";
    };
  programs.home-manager.enable = true;
}
