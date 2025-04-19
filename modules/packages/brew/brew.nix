{ pkgs, config, ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
    };
    brews = [
      "mas"
      "mysql-client@8.4"
      "komiser"
      "yq"
    ];
    taps = [
      "tailwarden/komiser"
    ];
   masApps = {
      "1Password for Safari" = 1569813296;
      "AllMyBatteries" = 1621263412;
      "Amazon Prime Video" = 545519333;
      "Apple Configurator" = 1037126344;
      "AwardWallet" = 1473828829;
      "Brother P-touch Editor" = 1453365242;
      "Brother iPrint&Scan" = 1193539993;
      "Deliveries" = 290986013;
      "Developer" = 640199958;
      "FakespotSafari" = 1592541616;
      "Flighty - Live Flight Tracker" = 1358823008;
      "Grammarly for Safari" = 1462114288;
      "HotKey" = 975890633;
      "Infuse" = 1136220934;
      "Keynote" = 409183694;
      "Kindle Classic" = 405399194;
      "Magnet" = 441258766;
      "MenubarX" = 1575588022;
      "Microsoft OneNote" = 784801555;
      "Microsoft Remote Desktop" = 1295203466;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "Parcel" = 639968404;
      "Pluralsight" = 431748264;
      "Pure Paste" = 1611378436;
      "Tailscale" = 1475387142;
      "Twingate" = 1501592214;
      "Wallabag QuickSave" = 1621482657;
      "WhatsApp Messenger" = 310633997;
      "Xcode" = 497799835;
      "Yubico Authenticator" = 1497506650;
      "iCaching" = 420484346;
      "reMarkable" = 1276493162;
    };
  };
}

