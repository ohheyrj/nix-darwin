{ config, pkgs, ... }:


{
  programs.zsh = {
    enable = true;
    sessionVariables = {
      TEST_VAR = "vim";
    };
    oh-my-zsh = {
      enable = false;
    };
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      ls = "eza";
      ll = "eza -al";
      lst = "eza --tree";
      update-nix = "darwin-rebuild switch --flake ~/nix";
      update-nix-trace = "darwin-rebuild switch --flake ~/nix --show-trace";
    };
    initExtra = ''
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
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
      # Shell interations
      if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
              eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/terminal.toml)"
      fi

      if [[ "$OSTYPE" == "darwin"* ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
      export EDITOR=nvim
    '';
    zplug ={
      enable = true;
      plugins = [
        {
          name = "zsh-users/zsh-syntax-highlighting";
        }
        {
          name = "zsh-users/zsh-completions";
        }
        {
          name = "zsh-users/zsh-autosuggestions";
        }
        {
          name = "Aloxaf/fzf-tab";
        }
        {
          name = "plugins/git";
          tags = ["from:oh-my-zsh"];
        }
        {
          name = "plugins/sudo";
          tags = ["from:oh-my-zsh"];
        }
        {
          name = "plguins/aws";
          tags = ["from:oh-my-zsh"];
        }
        {
          name = "plugins/kubectl";
          tags = ["from:oh-my-zsh"];
        }
        {
          name = "plugins/kubectx";
          tags = ["from:oh-my-zsh"];
        }
        {
          name = "plugins/command-not-found";
          tags = ["from:oh-my-zsh"];
        }
        {
          name = "plugins/terraform";
          tags = ["from:oh-my-zsh"];
        }
        {
          name = "plugins/vscode";
          tags = ["from:oh-my-zsh"];
        }
    ];
    };  
};
}
