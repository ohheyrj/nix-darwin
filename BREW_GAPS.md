# Brew Gaps

This list covers packages referenced by the Nix package modules that do not map cleanly to a Homebrew formula or cask.

## Direct download or manual install

- `cloudlens`
- `garmin-basecamp`
- `kics`
- `kobo-desktop`
- `kor`
- `kubespy`
- `mcfly-fzf`
- `openaudible`
- `ps-remote-play`
- `tfautomv`
- `twitch-tui`

## Install outside Homebrew

- `black` via `pipx install black`
- `cruft` via `pipx install cruft`
- `gitlint` via `pipx install gitlint`
- `gitmoji-cli` via `npm install -g gitmoji-cli`
- `podman-compose` via `pipx install podman-compose`

## Krew plugin rather than Brew

- `kube-capacity` via `kubectl krew install resource-capacity`

## Nix-specific or probably removable

- `cachix`
- `devenv`
- `nix-search-tv`
- `pinentry-curses`
- `python313Packages.pip`
- `statix`
- `undmg`

## Notes

- `handbrake`, `chatterino`, `cryptomator`, `alfred`, and `hazel` were in NUR but do have Homebrew casks, so they were moved into `Brewfile`.
- I could not validate against the live Homebrew index in this session because network access is restricted, so this file is based on the repo's existing migration notes plus the package names already present in your configuration.
