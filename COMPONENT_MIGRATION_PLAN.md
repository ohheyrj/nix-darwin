# Migration Plan By Component

This plan is based on the code in this repo, not a generic Nix teardown.

Recommended target stack:

- `brew bundle` for packages, casks, taps, and Mac App Store apps
- plain shell scripts for macOS defaults and one-off system tweaks
- `stow` for dotfiles
- `mise` for language runtimes if you want versioned runtimes without Nix
- `pre-commit` for repo-local hooks that are currently coming from `devenv`

## 1. `flake.nix`

Current role:

- wires together `nix-darwin`
- imports system modules from `modules/`
- enables `home-manager`
- enables `nix-homebrew`
- enables `mac-app-util`

Migration target:

- replace the flake with a normal bootstrap entrypoint:
  - `Brewfile`
  - `scripts/macos-defaults.sh`
  - `scripts/bootstrap.sh`
  - `dotfiles/` managed by `stow`

Suggested bootstrap script:

```bash
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

brew bundle --file=Brewfile
./scripts/macos-defaults.sh
./scripts/setup-pam-sudo.sh
stow -d dotfiles -t "$HOME" zsh git ssh gpg tmux
```

## 2. `modules/mac-config.nix`

Current role:

- Dock layout and behavior
- menu bar clock settings
- Finder sort column
- automatic light/dark switching

Migration target:

- move this to `scripts/macos-defaults.sh`

Snippet:

```bash
#!/usr/bin/env bash
set -euo pipefail

defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock tilesize -int 44
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock persistent-apps -array

defaults write com.apple.menuextra.clock Show24Hour -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowDate -int 1

defaults write com.apple.finder sortColumn -string name

killall Dock || true
killall Finder || true
```

## 3. `modules/keymapping.nix`

Current role:

- remaps Caps Lock to Control

Migration target:

- simplest: configure in System Settings
- better: keep it scripted with `hidutil` via LaunchAgent

Snippet:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>local.hidutil.caps-to-control</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/bin/hidutil</string>
      <string>property</string>
      <string>--set</string>
      <string>{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>
```

Load it with:

```bash
launchctl bootstrap "gui/$UID" ~/Library/LaunchAgents/local.hidutil.caps-to-control.plist
```

## 4. `modules/security.nix`

Current role:

- enables Touch ID and Watch unlock for `sudo`

Migration target:

- manage `/etc/pam.d/sudo_local` with a small script

Snippet:

```bash
#!/usr/bin/env bash
set -euo pipefail

sudo install -d /etc/pam.d
cat <<'EOF' | sudo tee /etc/pam.d/sudo_local >/dev/null
auth       sufficient     pam_tid.so
auth       sufficient     pam_watchid.so
EOF
```

## 5. `homebrew.nix`

Current role:

- Mac App Store app installation through `mas`
- Homebrew auto-update behavior through Nix

Migration target:

- move all of this into `Brewfile`
- run `brew bundle` directly or from bootstrap

Snippet:

```ruby
tap "homebrew/bundle"

brew "mas"

mas "1Password for Safari", id: 1569813296
mas "AllMyBatteries", id: 1621263412
mas "Apple Configurator", id: 1037126344
mas "Flighty - Live Flight Tracker", id: 1358823008
mas "Magnet", id: 441258766
mas "Tailscale", id: 1475387142
mas "Xcode", id: 497799835
```

Replace Nix auto-update with either:

```bash
brew update && brew upgrade && brew cleanup
```

or a recurring `brew bundle` run.

## 6. `modules/packages/nix/applications.nix`

Current role:

- general CLI tools
- GUI apps
- some personal NUR packages

Migration target:

- move standard packages to `Brewfile`
- replace NUR apps with Homebrew casks where available
- track truly manual installs in a short `MANUAL_APPS.md`

Snippet:

```ruby
brew "fd"
brew "fzf"
brew "htop"
brew "jq"
brew "ncdu"
brew "ripgrep"
brew "shellcheck"
brew "stow"
brew "tree"
brew "watch"
brew "wget"
brew "yq"
brew "zoxide"
brew "gnupg"
brew "pinentry-mac"
brew "ykman"
brew "ykpers"
brew "age"
brew "sops"

cask "1password-cli"
cask "alt-tab"
cask "chatgpt"
cask "cryptomator"
cask "drawio"
cask "handbrake"
cask "hazel"
cask "utm"
cask "zoom"
```

Packages to drop or handle manually:

- `nix-search-tv`: remove
- `mcfly-fzf`: manual install or drop
- `twitch-tui`: manual install
- `cruft`: install with `uv tool install cruft` or `pipx install cruft`

## 7. `modules/packages/nix/development.nix`

Current role:

- editor and dev tooling
- git tooling
- image/docs helpers
- some Nix-only tools

Migration target:

- Homebrew for most tools
- `uv tool` or `pipx` for Python CLIs
- `npm -g` only where there is no good brew package
- drop Nix-only tools entirely

Snippet:

```ruby
brew "ghq"
brew "gitleaks"
brew "glab"
brew "graphviz"
brew "hugo"
brew "markdownlint-cli"
brew "neovim"
brew "oxipng"
brew "pipenv"
brew "pngquant"
brew "pre-commit"
brew "swiftlint"
brew "yamllint"

cask "bruno"
cask "dbeaver-community"
cask "gitkraken"
```

Python and Node tools:

```bash
uv tool install black
uv tool install gitlint
npm install -g gitmoji-cli
```

Drop:

- `devenv`
- `statix`
- `cachix`
- `undmg`

## 8. `modules/packages/nix/infrastructure.nix`

Current role:

- cloud, Terraform, container, and Kubernetes tooling

Migration target:

- Homebrew for almost all of this
- keep taps in `Brewfile`
- move the rare gaps to direct install notes

Snippet:

```ruby
tap "fluxcd/tap"
tap "hashicorp/tap"

brew "argocd"
brew "aws-nuke"
brew "awscli"
brew "cilium-cli"
brew "dive"
brew "flux"
brew "infracost"
brew "k9s"
brew "kubectl"
brew "kubectx"
brew "kubeconform"
brew "krew"
brew "packer"
brew "pluto"
brew "podman"
brew "podman-compose"
brew "terraform-ls"
brew "tflint"
brew "tfsec"
brew "trivy"
brew "vault"
brew "velero"
```

Potential manual-review list because package names vary or taps move:

- `cloudlens`
- `granted`
- `inframap`
- `tfautomv`
- `podman-tui`
- `kor`
- `kubespy`
- `pv-migrate`
- `kubent`

## 9. `modules/packages/nix/languages-and-databases.nix`

Current role:

- installs Go, Node, Python, Flutter, and PostgreSQL globally

Migration target:

- do not keep language runtimes globally pinned in Homebrew unless you want machine-wide latest
- better replacement: `mise`

Snippet:

```toml
[tools]
go = "latest"
node = "22"
python = "3.13"
flutter = "latest"
```

Install:

```bash
brew install mise postgresql@16
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
```

If you want the simpler route, use Homebrew only:

```ruby
brew "go"
brew "node@22"
brew "python@3.13"
brew "flutter"
brew "postgresql@16"
```

## 10. `modules/home-manager.nix`

Current role:

- user-scoped package/config management
- enables `eza` and `lazygit`
- imports all files in `modules/home-manager/`

Migration target:

- move to real dotfiles under `dotfiles/`
- keep package installation in `Brewfile`
- keep configuration in checked-in files symlinked by `stow`

Suggested structure:

```text
dotfiles/
  git/.gitconfig
  zsh/.zshrc
  ssh/.ssh/config
  gpg/.gnupg/gpg-agent.conf
  tmux/.tmux.conf
  lazygit/Library/Application Support/lazygit/config.yml
```

## 11. `modules/home-manager/git.nix`

Current role:

- Git identity
- signing defaults
- editor
- `ghq` root

Migration target:

- move to `dotfiles/git/.gitconfig`

Snippet:

```ini
[user]
	name = Richard Annand
	email = richard@ohheyrj.co.uk

[init]
	defaultBranch = main

[pull]
	ff = only

[push]
	autoSetupRemote = true

[core]
	editor = nvim

[gpg]
	program = /opt/homebrew/bin/gpg

[commit]
	gpgsign = true

[ghq]
	root = /Users/richard/repos
```

## 12. `modules/home-manager/github.nix`

Current role:

- installs GitHub CLI
- installs `gh-dash`

Migration target:

- install with Homebrew
- store runtime config in `~/.config/gh` only if you care to version it

Snippet:

```ruby
brew "gh"
brew "gh-dash"
```

## 13. `modules/home-manager/gpg.nix`

Current role:

- GPG defaults
- gpg-agent with SSH support
- pinentry set to macOS app

Migration target:

- keep package install in `Brewfile`
- store config in `dotfiles/gpg`

Snippets:

`~/.gnupg/gpg.conf`

```conf
keyserver hkps://keys.openpgp.org
```

`~/.gnupg/gpg-agent.conf`

```conf
enable-ssh-support
default-cache-ttl 3600
max-cache-ttl 7600
pinentry-program /opt/homebrew/bin/pinentry-mac
```

Reload:

```bash
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent
```

## 14. `modules/home-manager/ssh.nix`

Current role:

- SSH match block for `*.amazonaws.com`

Migration target:

- move to `dotfiles/ssh/.ssh/config`

Snippet:

```sshconfig
Host *.amazonaws.com
  User ec2-user
  SetEnv TERM=xterm-256color
```

## 15. `modules/home-manager/tmux.nix`

Current role:

- enables tmux
- 12-hour clock

Migration target:

- install `tmux` with Homebrew
- move config to `dotfiles/tmux/.tmux.conf`

Snippet:

```tmux
set -g clock-mode-style 12
```

## 16. `modules/home-manager/firefox.nix`

Current role:

- enables Firefox
- installs 1Password extension via Nix

Migration target:

- install Firefox with Homebrew if you want it managed
- install browser extensions through Firefox Sync or manual install

Snippet:

```ruby
cask "firefox"
```

Recommendation:

- do not try to keep browser extensions declarative unless you have a stronger requirement than convenience

## 17. `modules/home-manager/zsh.nix`

Current role:

- aliases
- env vars
- history behavior
- `oh-my-posh`
- `fzf` and `zoxide` init
- `zplug` plugins
- adds `$HOME/.npm-global/bin` to `PATH`

Migration target:

- move to `dotfiles/zsh/.zshrc`
- keep plugin management, but simplify if possible

Snippet:

```zsh
export PATH="$HOME/.npm-global/bin:$PATH"
export EDITOR=nvim
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"

alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias ls='eza'
alias ll='eza -al'
alias lst='eza --tree'
alias lss='ls -al --sort newest'
alias assume='source assume'
alias docker='podman'

SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

autoload -U compinit && compinit
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/terminal.toml)"
fi
```

If you keep `zplug`:

```zsh
source "$(brew --prefix)/opt/zplug/init.zsh"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "Aloxaf/fzf-tab"
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/aws", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/kubectx", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/terraform", from:oh-my-zsh
zplug "plugins/vscode", from:oh-my-zsh

zplug load
```

Things to remove during migration:

- `update-nix`
- `update-nix-trace`
- `ns`

## 18. `devenv.nix`, `devenv.yaml`, `.envrc`

Current role:

- local project shell setup through `devenv`
- installs `trufflehog` and `gitleaks`
- runs a `gitleaks` pre-commit hook
- `.envrc` bootstraps `devenv`

Migration target:

- replace this with plain `pre-commit`
- keep `direnv` only if you still want auto-loading env files

Snippet:

`.pre-commit-config.yaml`

```yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.23.1
    hooks:
      - id: gitleaks
```

Bootstrap:

```bash
brew install pre-commit gitleaks trufflehog direnv
pre-commit install
```

If you no longer need direnv here, replace `.envrc` with nothing and delete it.

If you do want a tiny `.envrc`:

```bash
layout python3
PATH_add .bin
```

## 19. Fonts module

Current role:

- would install Nerd Fonts, but it is currently commented out in `flake.nix`

Migration target:

- either ignore it
- or move fonts to Homebrew casks

Snippet:

```ruby
cask "font-fira-code-nerd-font"
cask "font-meslo-lg-nerd-font"
cask "font-ubuntu-mono-nerd-font"
cask "font-ubuntu-sans-nerd-font"
```

## 20. Order Of Operations

1. Freeze what you actually want to keep. This repo contains overlap between Nix packages and the existing `Brewfile`.
2. Make `Brewfile` the source of truth for packages, casks, taps, and MAS apps.
3. Move shell, Git, SSH, GPG, tmux, and lazygit config into `dotfiles/`.
4. Add `scripts/macos-defaults.sh` and `scripts/setup-pam-sudo.sh`.
5. Replace `devenv` with `pre-commit` and optional `direnv`.
6. Install runtimes with `mise` or Homebrew.
7. Run the new bootstrap process on a clean shell before uninstalling Nix.
8. Remove Nix-only aliases and tools.

## 21. What I Would Actually Do

If the goal is "I want this machine manageable again", do this:

- keep `Brewfile`
- create `dotfiles/` plus `stow`
- add two scripts for macOS defaults and PAM
- use `mise` for Go, Node, Python, and Flutter
- delete `devenv` from this repo
- delete the entire Nix stack only after the brew/stow bootstrap reproduces your shell and tooling

That gives you a setup that is:

- inspectable without Nix knowledge
- easy to rerun on a new Mac
- close to what this repo already manages today
