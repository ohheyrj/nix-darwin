{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    fira-code-nerdfont
    nerd-fonts.meslo-lg
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
  ];
}
