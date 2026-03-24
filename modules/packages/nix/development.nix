{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Development Tools
    black
    devenv
    # Moved to Brewfile:
    # gitkraken
    # graphviz
    # pipenv
    # pre-commit
    statix
    # ngrok
    undmg
    cachix
    # dbeaver-bin
    # TODO: fix broken postman package
    #postman
    # bruno
    # fastlane
    # swiftlint

    # Git tools
    # ggshield
    # ghq
    # gitleaks
    gitlint
    gitmoji-cli
    # glab
    # bfg-repo-cleaner
    # mr
    # gitkraken

    # Documentation Tools
    # hugo
    # markdownlint-cli
    # neovim
    # yamllint
    # yq

    # pngquant
    # oxipng
  ];
}
