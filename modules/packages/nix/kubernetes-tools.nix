{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
