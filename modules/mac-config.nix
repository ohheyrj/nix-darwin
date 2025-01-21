{ pkgs, ... }: {
  system.defaults.LaunchServices = {
    LSDisabledMediaTypes = [
      "com.apple.disc-burning-device"
      "com.apple.disk-image"
      "com.apple.dvd"
    ];
  };
}
