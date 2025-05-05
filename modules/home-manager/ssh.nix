{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = [
      {
        "*.*.compute.amazonaws.com" = {
          hostname = "*.*.compute.amazonaws.com";
          user = "ec2-user";
          setenv = "TERM=xterm-256color";
        };
      }
    ];
  };
}

