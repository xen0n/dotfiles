# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list '' '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename '/home/xenon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=2048
SAVEHIST=4096
bindkey -e
# End of lines configured by zsh-newuser-install

# added by travis gem
source /home/xenon/.travis/travis.sh
