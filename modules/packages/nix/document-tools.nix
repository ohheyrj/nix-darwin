{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    hugo
    markdownlint-cli
    neovim
    yamllint
    yq
  ];
}
