{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    python310
    python311
    python312
    python313
 ];
}
