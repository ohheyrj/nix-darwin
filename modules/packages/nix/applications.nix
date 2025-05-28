{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    exercism
    watch
    fd
    ncdu
    wget
    yq
    hub
    mas
    wtfutil
    gimp
    _1password-cli
    chatgpt
    brave
    gnupg
    pinentry_mac
    yubikey-manager
    yubikey-personalization
    paperkey
    pinentry-curses
    alt-tab-macos
    # TODO: package handbrake
    # handbrake
    nur.repos.ohheyrj.chatterino
    nur.repos.ohheyrj.kobo-desktop
    nur.repos.ohheyrj.openaudible
    nur.repos.ohheyrj.ps-remote-play
    nur.repos.ohheyrj.bartender5
    nur.repos.ohheyrj.cryptomator
    # TODO: package calibre
    # calibre
    slack
    # TODO: package signal
    # signal-desktop
    discord
  ];
}
