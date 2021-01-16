export PATH=~/bin:~/.local/bin:$PATH

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  fasd
  git
  history-substring-search
  ssh-agent
  tmux
)

if which lsb_release &> /dev/null && lsb_release -i | grep -qi Ubuntu; then
  plugins+=(debian)
fi

export TMUX_SHELL=$SHELL
[[ -s ~/.zshrc.local ]] && source ~/.zshrc.local

# Dont run tmux if we're root:
if [[ $UID -eq 0 ]]; then
  SKIP_TMUX=true
fi

if [[ -z "$SKIP_TMUX" ]]; then
  if [[ -z $TMUX ]]; then
    tmux -2 $TMUX_ACTION
  fi

  while [[ -z $TMUX ]]; do
    tmux -2 attach || break
  done
fi

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh_custom

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
[[ -z $ZSH_THEME ]] && export ZSH_THEME="buys"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment if you want to use tmux window names instead of auto-titling:
export DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

source $ZSH/oh-my-zsh.sh

# correction almost always gets it wrong :(
setopt nocorrect
setopt nocorrectall

# disable usernames showing up as completions for cd
setopt NO_CDABLE_VARS

export EDITOR="vim"

source $HOME/.aliases
