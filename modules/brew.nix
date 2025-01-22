{ pkgs, config, ... }: {
  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    masApps = {
      "Yoink" = 457622435;
    };
  };
}

