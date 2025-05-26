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
    # TODO: package calibre
    #    calibre
  ];
}
