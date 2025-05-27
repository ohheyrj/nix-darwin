{ pkgs, system, ... }: {
  system.primaryUser = "richard";
  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
  };
  # TODO: Fix this code to be able to run again
  #  system.activationScripts.extraActivation.text = ''
  #  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  #'';
}
