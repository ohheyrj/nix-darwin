# Migrating Away from nix-darwin: Complete Reference

This document catalogues everything your nix-darwin flake currently manages on your Mac (`EvilCorp`), so you can replicate each piece through whatever tooling you choose.

---

## 1. Architecture Overview

Your current setup uses several interconnected Nix components:

- **nix-darwin** — manages system-level macOS settings, packages, and services
- **home-manager** — manages user-level dotfiles and program configurations (git, zsh, ssh, gpg, tmux, firefox, GitHub CLI)
- **nix-homebrew** — manages Homebrew itself declaratively through Nix, including Mac App Store apps
- **mac-app-util** — ensures Nix-installed GUI apps appear in Spotlight and the Applications folder
- **NUR (Nix User Repository)** — provides custom packages via `ohheyrj` overlay (Garmin BaseCamp, HandBrake, Chatterino, Kobo Desktop, OpenAudible, PS Remote Play, Cryptomator, Alfred 5, Hazel)
- **devenv** — used separately for per-project development environments (with gitleaks pre-commit hooks)

The flake targets `aarch64-darwin` (Apple Silicon) and builds via:

```bash
darwin-rebuild switch --flake ~/nix
```

---

## 2. System-Level macOS Settings

**Source:** `modules/mac-config.nix`, `modules/keymapping.nix`, `modules/security.nix`

These are `defaults write` equivalents that nix-darwin applies on each rebuild. To replicate them manually, run the corresponding `defaults` commands.

### Keyboard Remapping

| Setting | Current Value | Manual Equivalent |
|---------|--------------|-------------------|
| Key mapping enabled | `true` | Handled via `hidutil` — see below |
| Caps Lock → Control | `true` | System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys → Caps Lock → Control |

Nix-darwin uses `hidutil` property mappings under the hood. The manual approach is either the System Settings UI or a `hidutil` LaunchAgent.

### Dock

| Setting | Value | `defaults write` Command |
|---------|-------|--------------------------|
| Autohide | `true` | `defaults write com.apple.dock autohide -bool true` |
| Orientation | `left` | `defaults write com.apple.dock orientation -string left` |
| Tile size | `44` | `defaults write com.apple.dock tilesize -int 44` |
| Show recents | `false` | `defaults write com.apple.dock show-recents -bool false` |
| Persistent apps | `[]` (empty) | `defaults write com.apple.dock persistent-apps -array` |

After changing dock defaults: `killall Dock`

### Menu Bar Clock

| Setting | Value | `defaults write` Command |
|---------|-------|--------------------------|
| 24-hour time | `true` | `defaults write com.apple.menuextra.clock Show24Hour -bool true` |
| Show day of week | `true` | `defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true` |
| Show date | `1` (always) | `defaults write com.apple.menuextra.clock ShowDate -int 1` |

### Finder

| Setting | Value | `defaults write` Command |
|---------|-------|--------------------------|
| Sort column | `name` | `defaults write com.apple.finder sortColumn -string name` |

### Appearance

| Setting | Value | Notes |
|---------|-------|-------|
| Auto interface style switching | `true` | System Settings → Appearance → set to "Auto" |

### Touch ID / Watch for sudo

**Source:** `modules/security.nix`

| Setting | Value | Manual Equivalent |
|---------|-------|-------------------|
| Touch ID for sudo | `true` | Add `auth sufficient pam_tid.so` to `/etc/pam.d/sudo_local` |
| Watch ID for sudo | `true` | Add the `pam_watchid.so` line to `/etc/pam.d/sudo_local` |

Create `/etc/pam.d/sudo_local` with:

```
auth       sufficient     pam_tid.so
auth       sufficient     pam_watchid.so
```

---

## 3. System Packages (Nix)

**Source:** `modules/packages/nix/*.nix`

These are all installed into the system profile via `environment.systemPackages`. After removing Nix, you'd install these via Homebrew (`brew install`), direct download, or another package manager.

### Applications & Utilities (`applications.nix`)

| Package | Homebrew Equivalent | Notes |
|---------|-------------------|-------|
| `watch` | `brew install watch` | |
| `fd` | `brew install fd` | |
| `ncdu` | `brew install ncdu` | |
| `wget` | `brew install wget` | |
| `yq` | `brew install yq` | |
| `hub` | `brew install hub` | |
| `mas` | `brew install mas` | Mac App Store CLI |
| `wtfutil` | `brew install wtfutil` | |
| `_1password-cli` | `brew install --cask 1password-cli` | |
| `chatgpt` | `brew install --cask chatgpt` | |
| `gnupg` | `brew install gnupg` | |
| `pinentry_mac` | `brew install pinentry-mac` | |
| `yubikey-manager` | `brew install ykman` | |
| `yubikey-personalization` | `brew install ykpers` | |
| `paperkey` | `brew install paperkey` | |
| `pinentry-curses` | Included with `gnupg` | |
| `alt-tab-macos` | `brew install --cask alt-tab` | |
| `age` | `brew install age` | |
| `fzf` | `brew install fzf` | |
| `gpgme` | `brew install gpgme` | |
| `htop` | `brew install htop` | |
| `jq` | `brew install jq` | |
| `mcfly` | `brew install mcfly` | |
| `mcfly-fzf` | Manual install (not in Homebrew) | Check GitHub releases |
| `mkpasswd` | `brew install mkpasswd` or use `openssl passwd` | |
| `neofetch` | `brew install neofetch` | Archived; consider `fastfetch` |
| `nmap` | `brew install nmap` | |
| `oh-my-posh` | `brew install jandedobbeleer/oh-my-posh/oh-my-posh` | |
| `ripgrep` | `brew install ripgrep` | |
| `shellcheck` | `brew install shellcheck` | |
| `speedtest-cli` | `brew install speedtest-cli` | |
| `stow` | `brew install stow` | |
| `tmux` | `brew install tmux` | |
| `tree` | `brew install tree` | |
| `zoxide` | `brew install zoxide` | |
| `sops` | `brew install sops` | |
| `utm` | `brew install --cask utm` | |
| `dialog` | `brew install dialog` | |
| `_7zz` | `brew install 7zip` | |
| `nix-search-tv` | Nix-specific tool — no equivalent | Drop or replace with `brew search` |
| `drawio` | `brew install --cask drawio` | |
| `keybase` | `brew install --cask keybase` | |
| `lastfm` | `brew install --cask last-fm` | |
| `zoom-us` | `brew install --cask zoom` | |
| `diff-so-fancy` | `brew install diff-so-fancy` | |
| `twitch-tui` | Manual install from GitHub | |
| `cookiecutter` | `brew install cookiecutter` | |
| `cruft` | `pip install cruft` | |

### NUR Custom Packages (`applications.nix` via `nur.repos.ohheyrj.*`)

These are custom-packaged apps from your personal NUR repository. They'll need manual installation:

| Package | Installation Method |
|---------|-------------------|
| `garmin-basecamp` | Download from [garmin.com](https://www.garmin.com/en-US/software/basecamp/) |
| `handbrake` | `brew install --cask handbrake` |
| `chatterino` | `brew install --cask chatterino` |
| `kobo-desktop` | Download from [kobo.com](https://www.kobo.com/desktop) |
| `openaudible` | Download from [openaudible.org](https://openaudible.org) |
| `ps-remote-play` | Download from [playstation.com](https://remoteplay.dl.playstation.net/remoteplay/) |
| `cryptomator` | `brew install --cask cryptomator` |
| `alfred5` | `brew install --cask alfred` |
| `hazel` | `brew install --cask hazel` |

### Development Tools (`development.nix`)

| Package | Homebrew Equivalent | Notes |
|---------|-------------------|-------|
| `black` | `pip install black` | Python formatter |
| `devenv` | Nix-specific — drop or keep Nix just for this | |
| `gitkraken` | `brew install --cask gitkraken` | Listed twice in source |
| `graphviz` | `brew install graphviz` | |
| `pipenv` | `brew install pipenv` | |
| `pre-commit` | `brew install pre-commit` | |
| `statix` | Nix-specific linter — drop | |
| `ngrok` | `brew install ngrok/ngrok/ngrok` | |
| `undmg` | Nix-specific — not needed outside Nix | |
| `cachix` | Nix-specific — drop | |
| `dbeaver-bin` | `brew install --cask dbeaver-community` | |
| `bruno` | `brew install --cask bruno` | |
| `fastlane` | `brew install fastlane` | |
| `swiftlint` | `brew install swiftlint` | |
| `ghq` | `brew install ghq` | |
| `gitleaks` | `brew install gitleaks` | |
| `gitlint` | `pip install gitlint` | |
| `gitmoji-cli` | `npm install -g gitmoji-cli` | |
| `glab` | `brew install glab` | |
| `bfg-repo-cleaner` | `brew install bfg` | |
| `mr` | `brew install mr` | |
| `hugo` | `brew install hugo` | |
| `markdownlint-cli` | `brew install markdownlint-cli` | |
| `neovim` | `brew install neovim` | |
| `yamllint` | `brew install yamllint` | |
| `pngquant` | `brew install pngquant` | |
| `oxipng` | `brew install oxipng` | |

### Infrastructure & Cloud (`infrastructure.nix`)

| Package | Homebrew Equivalent | Notes |
|---------|-------------------|-------|
| `argocd` | `brew install argocd` | |
| `aws-nuke` | `brew install aws-nuke` | |
| `awscli2` | `brew install awscli` | |
| `cloudlens` | Manual install from GitHub | |
| `granted` | `brew tap common-fate/granted && brew install granted` | |
| `infracost` | `brew install infracost` | |
| `inframap` | `brew install inframap` | |
| `packer` | `brew install packer` | |
| `fluxcd` | `brew install fluxcd/tap/flux` | |
| `terraform-ls` | `brew install hashicorp/tap/terraform-ls` | |
| `tfautomv` | Manual install from GitHub | |
| `tflint` | `brew install tflint` | |
| `tfsec` | `brew install tfsec` | |
| `vault` | `brew install hashicorp/tap/vault` | |
| `cilium-cli` | `brew install cilium-cli` | |
| `dive` | `brew install dive` | |
| `trivy` | `brew install trivy` | |
| `podman` | `brew install podman` | |
| `podman-tui` | Manual install from GitHub | |
| `podman-compose` | `pip install podman-compose` | |
| `docker-credential-helpers` | `brew install docker-credential-helper` | |
| `lens` | `brew install --cask lens` | |
| `chart-testing` | `brew install chart-testing` | |
| `helm-docs` | `brew install helm-docs` | |
| `k9s` | `brew install derailed/k9s/k9s` | |
| `kics` | Manual install from GitHub | |
| `kompose` | `brew install kompose` | |
| `kor` | Manual install from GitHub | |
| `krew` | `brew install krew` | |
| `kube-capacity` | `kubectl krew install resource-capacity` | |
| `kube-linter` | `brew install kube-linter` | |
| `kubecm` | `brew install kubecm` | |
| `kubeconform` | `brew install kubeconform` | |
| `kubectl` | `brew install kubectl` | |
| `kubectx` | `brew install kubectx` | |
| `kubernetes-helm` | `brew install helm` | |
| `kubeseal` | `brew install kubeseal` | |
| `kubespy` | Manual install from GitHub | |
| `popeye` | `brew install derailed/popeye/popeye` | |
| `pv-migrate` | `brew install utkuozdemir/pv-migrate/pv-migrate` | |
| `velero` | `brew install velero` | |
| `pluto` | `brew install pluto` | |
| `kubent` | Manual install from GitHub | |

### Languages & Databases (`languages-and-databases.nix`)

| Package | Homebrew Equivalent | Notes |
|---------|-------------------|-------|
| `postgresql_16` | `brew install postgresql@16` | |
| `go` | `brew install go` | |
| `nodejs_22` | `brew install node@22` | |
| `python313` | `brew install python@3.13` | |
| `python313Packages.pip` | Bundled with Python from Homebrew | |
| `flutter` | `brew install --cask flutter` | |

### Fonts (`fonts.nix`) — Currently Commented Out

| Font | Installation |
|------|-------------|
| Fira Code Nerd Font | `brew install --cask font-fira-code-nerd-font` |
| MesloLG Nerd Font | `brew install --cask font-meslo-lg-nerd-font` |
| Ubuntu Mono Nerd Font | `brew install --cask font-ubuntu-mono-nerd-font` |
| Ubuntu Sans Nerd Font | `brew install --cask font-ubuntu-sans-nerd-font` |

Requires the cask-fonts tap: `brew tap homebrew/cask-fonts`

---

## 4. Homebrew Packages (Managed via nix-homebrew)

**Source:** `homebrew.nix`

Nix-homebrew currently manages Homebrew itself and the Mac App Store apps listed below. It also sets `onActivation.upgrade = true` and `autoUpdate = true`, meaning Homebrew and all its packages update on every `darwin-rebuild switch`.

### Mac App Store Apps

After migration, install these via `mas install <id>` or the App Store directly:

| App | App Store ID | `mas` Command |
|-----|-------------|---------------|
| 1Password for Safari | 1569813296 | `mas install 1569813296` |
| AllMyBatteries | 1621263412 | `mas install 1621263412` |
| Amazon Prime Video | 545519333 | `mas install 545519333` |
| Apple Configurator | 1037126344 | `mas install 1037126344` |
| AwardWallet | 1473828829 | `mas install 1473828829` |
| Brother P-touch Editor | 1453365242 | `mas install 1453365242` |
| Brother iPrint&Scan | 1193539993 | `mas install 1193539993` |
| Deliveries | 290986013 | `mas install 290986013` |
| Developer | 640199958 | `mas install 640199958` |
| Fakespot for Safari | 1592541616 | `mas install 1592541616` |
| Flighty | 1358823008 | `mas install 1358823008` |
| Grammarly for Safari | 1462114288 | `mas install 1462114288` |
| HotKey | 975890633 | `mas install 975890633` |
| Infuse | 1136220934 | `mas install 1136220934` |
| Keynote | 409183694 | `mas install 409183694` |
| Kindle Classic | 405399194 | `mas install 405399194` |
| Magnet | 441258766 | `mas install 441258766` |
| MenubarX | 1575588022 | `mas install 1575588022` |
| Microsoft OneNote | 784801555 | `mas install 784801555` |
| Numbers | 409203825 | `mas install 409203825` |
| Pages | 409201541 | `mas install 409201541` |
| Parcel | 639968404 | `mas install 639968404` |
| Pluralsight | 431748264 | `mas install 431748264` |
| Pure Paste | 1611378436 | `mas install 1611378436` |
| Tailscale | 1475387142 | `mas install 1475387142` |
| Wallabag QuickSave | 1621482657 | `mas install 1621482657` |
| WhatsApp Messenger | 310633997 | `mas install 310633997` |
| Xcode | 497799835 | `mas install 497799835` |
| iCaching | 420484346 | `mas install 420484346` |
| reMarkable | 1276493162 | `mas install 1276493162` |

### Legacy Brewfile

Your repo also contains a `Brewfile` with additional taps, brews, and casks that may predate the nix migration or serve as a reference. Notable items in the Brewfile but **not** in the Nix config include:

- **Taps:** `busser/tap`, `checkmarx/tap`, `env0/terratag`, `gabrie30/utils`, `jorgelbg/tap`, `lindell/multi-gitter`, `norwoodj/tap`, `peripheryapp/periphery`, `robscott/tap`, `robusta-dev/krr`, `steipete/tap`, `tailwarden/komiser`, `twitchdev/twitch`, `utkuozdemir/pv-migrate`, `vinivendra/gryphon`, `weaveworks/tap`
- **Brews not in Nix:** `xz`, `awslogs`, `bison`, `pycparser`, `cffi`, `chruby`, `cmake`, `coreutils`, `ctags`, `dfu-util`, `gcc`, `gdbm`, `hdf5`, `little-cms2`, `webp`, `jpeg-xl`, `libffi`, `libksba`, `libmatio`, `libraw`, `libssh2`, `libtool`, `libyaml`, `mysql-client@8.0`, `netpbm`, `ninja`, `open-mpi`, `qrencode`, `ruby-install`, `signal-cli`, `ykpers`, `zsh-autosuggestions`, `zsh-completions`, `komiser`, `twitch-cli`
- **Casks not in Nix:** `amazon-workspaces`, `blackhole-2ch`, `codexbar`, `ghostty`, `gitkraken-cli`, `google-drive`, `linphone`, `microsoft-auto-update`, `microsoft-excel`, `microsoft-powerpoint`, `microsoft-word`, `periphery`, `raspberry-pi-imager`, `steam`
- **MAS apps only in Brewfile:** `CotEditor` (1024640650), `Craft` (1487937127), `RapidClick` (419891002), `Telegram Lite` (946399090), `Twingate` (1501592214), `Yubico Authenticator` (1497506650)

Decide whether you still need these or if they're stale.

---

## 5. Home Manager — Dotfile Configurations

**Source:** `modules/home-manager/*.nix`

Home Manager declaratively generates dotfiles. After migration, you'll manage these files manually or with a tool like `stow`, `chezmoi`, or `yadm`.

### Git (`git.nix`)

Generates `~/.config/git/config`. Equivalent manual config:

```ini
[user]
    name = Richard Annand
    email = richard@ohheyrj.co.uk

[init]
    defaultBranch = main

[ghq]
    root = /Users/richard/repos

[pull]
    ff = only

[push]
    autoSetupRemote = true

[core]
    editor = nvim

[gpg]
    program = /usr/local/bin/gpg  # adjust path after installing gnupg via brew

[commit]
    gpgSign = true
```

### Zsh (`zsh.nix`)

Generates `~/.zshrc` and `~/.zshenv`. Key elements to replicate:

**Session path:**
```bash
export PATH="$HOME/.npm-global/bin:$PATH"
```

**Environment variables:**
```bash
export TEST_VAR="vim"
export SOPS_AGE_KEY_FILE="~/.config/sops/age/keys.txt"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export EDITOR=nvim
```

**Aliases:**
```bash
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias ls="eza"
alias ll="eza -al"
alias lst="eza --tree"
alias lss="ls -al --sort newest"
alias update-nix="darwin-rebuild switch --flake ~/nix"  # remove after migration
alias update-nix-trace="darwin-rebuild switch --flake ~/nix --show-trace"  # remove after migration
alias assume="source assume"
alias docker="podman"
alias ns="nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history"  # remove after migration
```

**Shell init (paste into `~/.zshrc`):**
```bash
autoload -U compinit && compinit
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Oh My Posh prompt
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/terminal.toml)"
fi

# Homebrew
if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# FZF and Zoxide
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
```

**Zsh plugins (via zplug):**

Install zplug manually (`brew install zplug`) and add to `~/.zshrc`:

```bash
source $(brew --prefix)/opt/zplug/init.zsh

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

### SSH (`ssh.nix`)

Generates `~/.ssh/config`:

```
Host *.amazonaws.com
    User ec2-user
    SetEnv TERM=xterm-256color
```

### GPG (`gpg.nix`)

Generates `~/.gnupg/gpg.conf` and GPG agent config:

**`~/.gnupg/gpg.conf`:**
```
keyserver hkps://keys.openpgp.org
```

**`~/.gnupg/gpg-agent.conf`:**
```
enable-ssh-support
default-cache-ttl 3600
max-cache-ttl 7600
pinentry-program /usr/local/bin/pinentry-mac
```

Note: `enable-ssh-support` means the GPG agent also acts as your SSH agent. If you rely on this for SSH key management via GPG, ensure you add `export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)` to your `~/.zshrc`.

After creating these files, restart the agent: `gpgconf --kill gpg-agent`

### Tmux (`tmux.nix`)

Generates `~/.tmux.conf`:

```
set-option -g clock-mode-style 12
```

Minimal config — add your own preferences as needed.

### Firefox (`firefox.nix`)

Creates a Firefox profile named `richard` with the 1Password extension pre-installed. After migration, install Firefox via `brew install --cask firefox` and add 1Password manually from [addons.mozilla.org](https://addons.mozilla.org).

### GitHub CLI (`github.nix`)

Installs `gh` with the `gh-dash` extension. After migration:

```bash
brew install gh
gh extension install dlvhdr/gh-dash
```

### Eza (`home-manager.nix`)

Home Manager configures `eza` with zsh integration, auto colors, and icons. After migration:

```bash
brew install eza
```

The zsh aliases (`ls = eza`, etc.) already cover the integration.

### Lazygit (`home-manager.nix`)

```bash
brew install lazygit
```

Then create `~/.config/lazygit/config.yml`:

```yaml
gui:
  nerdFontVersion: "3"
  showIcons: true
```

---

## 6. Other Nix-Managed System Config

### Nix Settings

| Setting | What It Does |
|---------|-------------|
| `experimental-features = "nix-command flakes"` | Nix-specific — not needed after migration |
| `trusted-users = ["root" "richard"]` | Nix-specific — not needed after migration |
| `programs.zsh.enable = true` | Ensures zsh is available — macOS includes zsh by default |
| `programs.direnv.enable = true` | After migration: `brew install direnv` and add `eval "$(direnv hook zsh)"` to `~/.zshrc` |
| `nixpkgs.config.allowUnfree = true` | Nix-specific — not needed |

### devenv (Per-Project Environments)

**Source:** `devenv.nix`, `devenv.yaml`

Your devenv config sets up gitleaks pre-commit hooks with trufflehog and gitleaks packages. After removing Nix, replicate this with:

```bash
pip install pre-commit
```

Then create `.pre-commit-config.yaml` in your projects:

```yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0  # update to latest
    hooks:
      - id: gitleaks
```

---

## 7. Uninstalling Nix

Once you've replicated everything above, remove Nix itself:

### Step 1: Back Up Your Config

```bash
cp -r ~/nix ~/nix-backup
```

### Step 2: Uninstall nix-darwin

```bash
darwin-rebuild switch --flake ~/nix --option substitute false  # one last build to ensure clean state
nix-env -e '*'  # remove all user-level nix packages
```

Then remove the nix-darwin activation:

```bash
# Remove the system link
sudo rm /run/current-system

# Remove nix-darwin build artifacts
rm -rf ~/nix/result
```

### Step 3: Uninstall Nix Package Manager

Follow the official guide for multi-user uninstall:

1. Stop the Nix daemon:
   ```bash
   sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
   sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
   ```

2. Remove build users and group:
   ```bash
   for i in $(seq 1 32); do
       sudo dscl . -delete /Users/_nixbld$i
   done
   sudo dscl . -delete /Groups/nixbld
   ```

3. Remove the Nix store:
   ```bash
   sudo rm -rf /nix
   ```

4. Remove Nix configuration files:
   ```bash
   sudo rm -rf /etc/nix
   rm -rf ~/.nix-profile
   rm -rf ~/.nix-defexpr
   rm -rf ~/.nix-channels
   rm -rf ~/.local/state/nix
   rm -rf ~/.cache/nix
   ```

5. Remove shell hooks — edit `/etc/zshrc` and `/etc/bashrc` to remove any lines referencing Nix (typically a sourced file like `nix-daemon.sh`).

6. Remove the APFS volume (if created during install):
   ```bash
   sudo diskutil apfs deleteVolume /nix
   ```

   Check with `diskutil list` first to confirm the volume exists.

7. Remove `/etc/synthetic.conf` entry:
   ```bash
   sudo sed -i '' '/^nix$/d' /etc/synthetic.conf
   ```

8. Reboot.

---

## 8. Post-Migration Checklist

- [ ] Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- [ ] Install all `brew` packages from the tables above
- [ ] Install all `mas` apps from the Mac App Store table
- [ ] Create `~/.gitconfig` from the Git section
- [ ] Create `~/.zshrc` from the Zsh section
- [ ] Create `~/.ssh/config` from the SSH section
- [ ] Create `~/.gnupg/gpg.conf` and `~/.gnupg/gpg-agent.conf` from the GPG section
- [ ] Create `~/.config/lazygit/config.yml` from the Lazygit section
- [ ] Install zplug and configure plugins
- [ ] Apply macOS defaults (dock, clock, finder, keyboard)
- [ ] Configure Touch ID for sudo
- [ ] Install `direnv` and add shell hook
- [ ] Install Firefox and add 1Password extension
- [ ] Install `gh` and add `gh-dash` extension
- [ ] Set up pre-commit hooks for projects that used devenv
- [ ] Remove Nix-specific aliases (`update-nix`, `ns`)
- [ ] Verify GPG signing works with git
- [ ] Back up and uninstall Nix
- [ ] Reboot and verify everything works
