export PATH=~/bin:~/.local/bin:$PATH
[[ -s ~/.zshrc.amazon ]] && source ~/.zshrc.amazon
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
[[ -z $ZSH_THEME ]] && export ZSH_THEME="buys"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(rails rails3 git ruby deb debian gem ssh-agent vi-mode)

source $ZSH/oh-my-zsh.sh

# correction almost always gets it wrong :(
setopt nocorrect
setopt nocorrectall

# disable usernames showing up as completions for cd
setopt NO_CDABLE_VARS

if [ -f $HOME/bin/vim-wrapper ]; then
  export EDITOR=$HOME/bin/vim-wrapper
else
  export EDITOR=`which vim`
fi

source $HOME/.aliases


fpath=(~/.rvm/scripts/zsh/Completion $fpath)
