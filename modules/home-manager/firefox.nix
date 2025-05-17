{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.richard = {
    extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
      onepassword-password-manager
    ];
    };
  };
}


