{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
  ];
}
