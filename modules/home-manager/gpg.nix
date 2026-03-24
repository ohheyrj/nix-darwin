{ config, pkgs, ... }:

{
  # Moved to ~/dotfiles/gpg/.gnupg/gpg.conf and gpg-agent.conf (managed by stow)
  # programs.gpg = {
  #   enable = true;
  #   settings = {
  #     keyserver = "hkps://keys.openpgp.org";
  #   };
  # };
  #
  # services.gpg-agent = {
  #   enable = true;
  #   enableSshSupport = true;
  #   defaultCacheTtl = 3600;
  #   maxCacheTtl = 7600;
  #   pinentry = {
  #     package = pkgs.pinentry_mac;
  #   };
  # };
}
