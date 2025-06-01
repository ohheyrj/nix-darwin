{ config, pkgs, ... }:
{
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
    # Uncomment if you use tmux/screen:
    # reattach = true;
  };
}