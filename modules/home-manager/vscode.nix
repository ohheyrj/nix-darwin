{ config, pkgs, ... }:
 {
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          github.copilot-chat
          github.copilot
          redhat.ansible
          njpwerner.autodocstring
          mkhl.direnv
          ms-azuretools.vscode-docker
          dbaeumer.vscode-eslint
          codezombiech.gitignore
          hashicorp.terraform
          oderwat.indent-rainbow
          ms-python.isort
          ms-kubernetes-tools.vscode-kubernetes-tools
          ms-vscode.live-server
          ritwickdey.liveserver
          yzhang.markdown-all-in-one
        ];
      };
    };
  };
 }
