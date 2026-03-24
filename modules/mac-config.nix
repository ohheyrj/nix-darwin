{ pkgs, system, ... }: {
  system.primaryUser = "richard";
  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
    dock = {
      autohide = true;
      orientation = "left";
      tilesize = 44;
      show-recents = false;
      persistent-apps = [];
    };
    menuExtraClock = {
      Show24Hour = true;
      ShowDayOfWeek = true;
      ShowDate = 1;
    };
    CustomUserPreferences = {
      "com.apple.finder" = {
        sortColumn = "name";
      };
    };
  };
}
