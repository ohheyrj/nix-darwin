{ pkgs, config, ... }: {
  homebrew = {
    enable = true;
    brews = [
      "mas"
      "mysql-client@8.4"
      "komiser"
    ];
    masApps = {
      "WhatsApp Messenger" = 310633997;
    };
  };
}

