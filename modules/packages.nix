{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    _1password-cli
    age
    ansible
    ansible-lint
    argocd
    aws-nuke
    awscli2
    bfg-repo-cleaner
    checkov
    cloudlens
    dive
    docker-compose
    exercism
    fluxcd
    fzf
    gh
    ghq
    gitleaks
    gitlint
    gitmoji-cli
    glab
    helm-docs
    htop
    hugo
    inetutils
    infracost
    inframap
    jq
    k9s
    kics
    kompose
    kube-capacity
    kube-linter
    kubecm
    kubectx
    kubernetes-helm
    kubeseal
    kubespy
    lazygit
    markdownlint-cli
    mas
    mcfly
    mkpasswd
    mr
    neofetch
    neovim
    nixos-rebuild
    nmap
    oh-my-posh
    packer
    pipenv
    popeye
    pre-commit
    pv-migrate
    shellcheck
    speedtest-cli
    stow
    terraform-docs
    terraform-ls
    tfautomv
    tflint
    tfsec
    tmux
    tree
    trivy
    velero
    yamllint
    yq
    zoxide
    chart-testing
    black
    ripgrep
    go
    kor
    kubectl
    krew
    nodejs_22
    gpgme
    gnupg
    mkalias
  ];
  system.activationScripts.applications.text = let
  env = pkgs.buildEnv {
    name = "system-applications";
    paths = config.environment.systemPackages;
    pathsToLink = "/Applications";
  };
in
  pkgs.lib.mkForce ''
  # Set up applications.
  echo "setting up /Applications..." >&2
  rm -rf /Applications/Nix\ Apps
  mkdir -p /Applications/Nix\ Apps
  find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
  while read -r src; do
    app_name=$(basename "$src")
    echo "copying $src" >&2
    ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
  done
      '';
}
