{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    exercism
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
    nur.repos.ohheyrj.chatterino
    nur.repos.ohheyrj.kobo-desktop
    nur.repos.ohheyrj.openaudible
    nur.repos.ohheyrj.ps-remote-play
    nur.repos.ohheyrj.bartender5
    # TODO: package calibre
    #    calibre
    # TODO: package https://cryptomator.org/for-individuals/
    #    cryptomator
  ];
}
