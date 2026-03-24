{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Cloud Tools
    ## Disabling ansible as there is an issue with the package install
    # ansible
    # ansible-lint
    # Moved to Brewfile:
    # argocd
    # aws-nuke
    # awscli2
    # checkov
    cloudlens
    # granted
    # infracost
    # inframap
    # packer
    # fluxcd
    #terraform-docs
    # terraform-ls
    tfautomv
    # tflint
    # tfsec
    # vault
    # cilium-cli

    # Container Tools
    # dive
    # trivy
    # podman
    podman-tui
    podman-compose
    # docker-credential-helpers
    lens # Outdated

    # Kubernetes Tools
    # chart-testing
    # helm-docs
    # k9s
    kics
    # kompose
    kor
    # krew
    kube-capacity
    # kube-linter
    # kubecm
    # kubeconform
    # kubectl
    # kubectx
    # kubernetes-helm
    # kubeseal
    kubespy
    # popeye
    # pv-migrate
    # velero
    # pluto
    kubent

  ];
}
