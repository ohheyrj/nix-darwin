## Updating packages

To update the packages, run:

```bash
nix flake update
```


## Compare changes to current system

To compare what will be applied at the next switch run the build command first:

```bash
darwin-rebuild build --flake .
```

This will build nix into folder called 'results'.

The run this command to compare what is going to change:

```bash
nix store diff-closures /run/current-system ./result
```

You should then see a comparison:

```
aws-nuke: 3.51.0 → 3.51.1
cachix: 1.7.7 → 1.7.8
checkov: 3.2.396 → 3.2.403
darwin-manual: +8.2 KiB
darwin-system: 25.05.73d5958 → 25.05.43975d7
devenv: 1.4.1 → 1.5, +2874.4 KiB
direnv: 2.35.0 → 2.36.0
docker-compose: 2.34.0 → 2.35.0, -1039.5 KiB
fzf: 0.61.0 → 0.61.1
ghq: 1.7.1 → 1.8.0
gitleaks: 8.24.2 → 8.24.3
gtest: ∅ → 1.16.0, +1816.6 KiB
hm_.zshenv: ∅ → ε
hm_.zshrc: ∅ → ε
home-manager: +11.8 KiB
htop: 3.4.0 → 3.4.1
hugo: 0.145.0 → 0.146.1, +146.1 KiB
kor: 0.6.0 → 0.6.1, +470.1 KiB
kubernetes-helm: 3.17.2 → 3.17.3
libblake3: ∅ → 1.8.0, +80.6 KiB
nix: 2.24.13 → 2.24.14, 2.28.1, +27944.3 KiB
python3: 3.9.21 → ∅, -74519.9 KiB
python3.12-ansible: 11.3.0 → 11.4.0, +521.3 KiB
python3.12-awscrt: 0.24.2 → 0.25.7, +1612.9 KiB
python3.12-bc-detect-secrets: 1.5.39 → 1.5.40
rapidcheck: ∅ → 0-unstable-2023-12-14, +744.5 KiB
source: +582.6 KiB
terraform-docs: 0.19.0 → 0.20.0
```

> [!NOTE]
> The '∅' symbol means that the file does not exist, the 'ε' symbol means the file will be created.

