{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    python313
 ];
}
