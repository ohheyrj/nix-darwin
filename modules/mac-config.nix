{ pkgs, system, ... }: {
  system.primaryUser = "richard";
  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
  };
  #  system.activationScripts.extraActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
