{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "test";
      ghq.root = "/Users/richard/repos";
      pull.ff = "only";
      push.autoSetupRemote = true;
      core.editor = "nvim";
    };
    signing = {
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFvk4TNmYsvW8rn3JN8NIo5Uv8d234beddKK5bAF51+a";
      signByDefault = true;
    };
    userName = "Richard Annand";
    userEmail = "richard+git@ohheyrj.co.uk";
  };
}
