{ pkgs, config, ... }: {
  homebrew = {
    brews = [
      "mas"
    ];
    masApps = {
      "Yoink" = 457622435;
    };
  };
}

