{ config, pkgs, ... }:

{
  # Moved to ~/dotfiles/.gitconfig (managed by stow)
  # programs.git = {
  #   enable = true;
  #   extraConfig = {
  #     init.defaultBranch = "main";
  #     ghq.root = "/Users/richard/repos";
  #     pull.ff = "only";
  #     push.autoSetupRemote = true;
  #     core.editor = "nvim";
  #     gpg.program = "${pkgs.gnupg}/bin/gpg";
  #   };
  #   signing = {
  #     signByDefault = true;
  #     key = null;
  #
  #   };
  #   userName = "Richard Annand";
  #   userEmail = "richard@ohheyrj.co.uk";
  # };
}
