{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Programming fonts
    fira-code
    fira-code-nerdfont
    jetbrains-mono
    source-code-pro
    hack-font
    
    # System fonts
    inter
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    
    # Other popular fonts
    roboto
    open-sans
  ];
}
