{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    python39
    python310
    python311
    python312
    python313
 ];
}
