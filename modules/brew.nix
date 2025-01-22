{ pkgs, config, ... }: {
  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    masApps = {
      "WhatsApp Messenger" = 310633997;
    };
  };
}

