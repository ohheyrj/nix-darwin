{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Moved to Brewfile:
    # watch
    # fd
    # ncdu
    # wget
    # yq
    # hub
    # mas
    # wtfutil
    # _1password-cli
    # chatgpt
    # gnupg
    # pinentry_mac
    # yubikey-manager
    # yubikey-personalization
    # paperkey
    pinentry-curses
    # alt-tab-macos
    nur.repos.ohheyrj.garmin-basecamp
    # nur.repos.ohheyrj.handbrake
    # nur.repos.ohheyrj.chatterino
    nur.repos.ohheyrj.kobo-desktop
    nur.repos.ohheyrj.openaudible
    nur.repos.ohheyrj.ps-remote-play
    # nur.repos.ohheyrj.bartender5
    # nur.repos.ohheyrj.cryptomator
    # nur.repos.ohheyrj.alfred5
    # nur.repos.ohheyrj.hazel
    # nur.repos.ohheyrj.calibre
    # age
    # fzf
    # gnupg
    # gpgme
    # htop
    # jq
    # mcfly
    mcfly-fzf
    # mkpasswd
    # neofetch
    # nmap
    # oh-my-posh
    # ripgrep
    # shellcheck
    # speedtest-cli
    # stow
    # tmux
    # tree
    # zoxide
    # sops
    # utm
    # dialog
    # _7zz
    nix-search-tv
    # daisydisk
    # drawio
    # keybase
    # lastfm
    # zoom-us
    # diff-so-fancy
    twitch-tui
    # cookiecutter
    cruft
  ];
}
