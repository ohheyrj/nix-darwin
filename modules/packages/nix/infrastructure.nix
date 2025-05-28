{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Cloud Tools
    ## Disabling ansible as there is an issue with the package install
    # ansible
    # ansible-lint
    argocd
    aws-nuke
    awscli2
    checkov
    cloudlens
    granted
    infracost
    inframap
    packer 
    fluxcd
    terraform-docs
    terraform-ls
    tfautomv
    tflint
    tfsec

    # Container Tools
    dive
    trivy
    podman
    podman-tui
    podman-compose
    lens # Outdated

    # Kubernetes Tools
    chart-testing
    helm-docs
    k9s
    kics
    kompose
    kor
    krew
    kube-capacity
    kube-linter
    kubecm
    kubeconform
    kubectl
    kubectx
    kubernetes-helm
    kubeseal
    kubespy
    popeye
    pv-migrate
    velero
    pluto

  ];
}
