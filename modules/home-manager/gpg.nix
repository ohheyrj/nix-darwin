{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 3600;
    maxCacheTtl = 7600;
    pinentryPackage = pkgs.pinentry_mac;
  };
}

