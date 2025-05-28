{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
  ];
}
