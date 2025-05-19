{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    custom-nix-packages.url = "github:ohheyrj/custom-nix-pkgs";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, mac-app-util, home-manager, custom-nix-packages, nur, ... }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
       # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.trusted-users = ["root" "richard"];
      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs.zsh.enable = true;
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config = {
          allowUnfree = true;
        };
      nixpkgs.overlays = [
          nur.overlays.default
        ];
      programs.direnv.enable = true;
      users.users.richard.home = /Users/richard;
      };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#EvilCorp
    darwinConfigurations."EvilCorp" = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit custom-nix-packages;
      };
      modules = [
          ./modules/keymapping.nix
          ./modules/mac-config.nix
          ./modules/packages/brew/brew.nix
          ./modules/packages/nix/applicaations.nix
          ./modules/packages/nix/cloud-tools.nix
          ./modules/packages/nix/container-tools.nix
          ./modules/packages/nix/dev-tools.nix
          ./modules/packages/nix/document-tools.nix
          ./modules/packages/nix/git-tools.nix
          ./modules/packages/nix/kubernetes-tools.nix
          ./modules/packages/nix/postgresql-version.nix
          ./modules/packages/nix/python-versions.nix
          ./modules/packages/nix/system-tools.nix
          ./modules/services/podman.nix
          ./modules/packages/nix/custom-packages.nix
          configuration
          mac-app-util.darwinModules.default
          nix-homebrew.darwinModules.nix-homebrew
          {
           nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "richard";
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [
                mac-app-util.homeManagerModules.default
              ];
            };
            home-manager.users.richard = import ./modules/home-manager.nix;
          }
        ];
    };
  };
}
