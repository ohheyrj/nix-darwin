{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    age
    fzf
    gnupg
    gpgme
    htop
    inetutils
    jq
    mcfly
    mkpasswd
    neofetch
    nixos-rebuild
    nmap
    oh-my-posh
    ripgrep
    shellcheck
    speedtest-cli
    stow
    tmux
    tree
    zoxide
    sops
    nixos-generators
  ];
}
