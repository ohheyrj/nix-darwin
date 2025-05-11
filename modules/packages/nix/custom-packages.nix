{ myrepo, ... }: {
  environment.systemPackages = with myrepo; [
    kobo-desktop
  ];
}
