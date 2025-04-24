{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = false;
  };
}
