{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
        "*.amazonaws.com" = {
          user = "ec2-user";
          setEnv = {
            "TERM" = "xterm-256color";
          };
        };
      };
  };
}

