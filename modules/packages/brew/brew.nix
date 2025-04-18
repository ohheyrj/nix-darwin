{ pkgs, config, ... }: {
  homebrew = {
    enable = true;
    brews = [
      "mas"
      "mysql-client@8.4"
      "komiser"
      "yq"
    ];
    masApps = {
      "tailwarden/komiser"
      "WhatsApp Messenger" = 310633997;
      "Amazon Prime Video" = 545519333;
      "Flighty - Live Flight Tracker" = 1358823008;
    };
  };
}

