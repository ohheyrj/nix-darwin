{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    fira-code-nerdfont
    nerd-fonts.meslo-lg
    nerd-fonts.ubuntu-sans
  ];
}
