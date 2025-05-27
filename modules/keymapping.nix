{ pkgs, ... }: {
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
  # TODO: Fix this code to be able to run again
  #  system.activationScripts.postUserActivation.text = ''
  #  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  #'';
}
