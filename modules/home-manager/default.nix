# ./home-manager/default.nix
let
  # Get all .nix files in the current directory
  files = builtins.attrNames (builtins.readDir ./.);
  
  # Filter to only include .nix files and exclude default.nix
  nixFiles = builtins.filter (n: 
    n != "default.nix" && 
    builtins.match ".*\\.nix" n != null
  ) files;
  
  # Convert filenames to paths
  paths = map (name: ./. + "/${name}") nixFiles;
in
  paths
