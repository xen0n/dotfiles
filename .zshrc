# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="xen0n"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump autopep8 bower celery coffee encode64 fabric git gitfast git-flow gradle mvn npm pip python svn-fast-info systemd urltools)

# User configuration
#. /etc/profile


# detect OS
local is_linux=false
local is_darwin=false
case `uname -s` in
	Darwin) is_darwin=true ;;
	Linux)  is_linux=true ;;
esac


# detect environment
local is_work=false
if [ -e ~/.xen0n-work-env ]; then
	is_work=true
fi


# for ccache...
# also for adb
if ! $is_work ; then
ANDROID_HOME="/android/android-sdk-linux"
#ANDROID_JAVA_HOME="/opt/icedtea-bin-7.2.4.7"
ANDROID_NDK_HOME="/android/android-ndk"
ANDROID_BUILD_TOOLS_VERSION="22.0.1"

# go
GOPATH=/home/xenon/local/go
fi

# macOS-specific path settings
if $is_darwin ; then
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export MANPATH
fi

# Build PATH additions in reverse order.
if ! $is_work; then
#PATH="/usr/lib64/ccache/bin:${PATH}"
PATH="${ANDROID_HOME}/build-tools/${ANDROID_BUILD_TOOLS_VERSION}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools:${ANDROID_NDK_HOME}:${PATH}"
PATH="${HOME}/.gem/ruby/2.4.0/bin:${PATH}"
PATH="${GOPATH}/bin:${PATH}"
fi
PATH="${HOME}/.cargo/bin:${PATH}"
PATH="${HOME}/local/bin:${PATH}"

export PATH
if ! $is_work; then
export ANDROID_HOME
#export ANDROID_JAVA_HOME
export ANDROID_NDK_HOME
export GOPATH
fi


# source oh-my-zsh after PATH export for it to pick up commands at custom
# locations
source $ZSH/oh-my-zsh.sh


# very big history
export HISTSIZE=100000
export SAVEHIST=100000


# set some alias
# this should go after oh-my-zsh initialization to override some of its
# alias choices
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias ls="ls --color=auto"
alias ll="ls -alF"

#alias grep="grep --color=auto"
#alias egrep="egrep --color=auto"

alias goi="go install"
alias goiv="go install -v ./..."

alias gpfork='git push fork $(git_current_branch)'
alias gporig='git push origin $(git_current_branch)'

if $is_work; then
	alias qn="ssh jumpbox"
	alias qssh="ssh jumpbox -t qssh"
	alias fssh="ssh jumpbox -t fssh"
fi

if ! $is_work; then
alias py="ipython"
alias py3="ipython3"
alias pyhttp="pypy -m SimpleHTTPServer"

alias enus="LANG=en_US.UTF-8"

alias weiyuactivate=". ~/kodez/exps/weiyutest/bin/activate"
alias rs="rain shell"
fi

alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'

# language...
#LANG=zh_CN.UTF-8

# dir_colors
eval `dircolors ~/.dir_colors`


# Detect term wrappers
# TODO: broken under macOS due to ps usage differences
if $is_linux; then
#WRAPPER_PID="$( ps -o ppid --no-headers | head -1 | tr -d "[:blank:]" )"
WRAPPER_PID="$PPID"

if [[ "x${WRAPPER_PID}" != "x" ]]; then
	WRAPPER_PROGRAM="$( ps -p "${WRAPPER_PID}" -o comm --no-headers )" ;
else
	WRAPPER_PROGRAM="unknown" ;
fi
# new version of tmux
if [[ "x${WRAPPER_PROGRAM}" == "xtmux: server" ]]; then
	WRAPPER_PROGRAM="tmux";
fi
#echo $WRAPPER_PROGRAM

echo $WRAPPER_PROGRAM | grep 'terminator' > /dev/null && WRAPPER_PROGRAM="terminator"

# set TERM variable
if [[ "x${WRAPPER_PROGRAM}" == "xfbterm" ]]; then
	TERM=fbterm ;
elif [[ "x${WRAPPER_PROGRAM}" == "xTerminal" ]]; then
	TERM=xterm-256color ;
elif [[ "x${WRAPPER_PROGRAM}" == "xgnome-terminal" ]]; then
	TERM=xterm-256color ;
elif [[ "x${WRAPPER_PROGRAM}" == "xterminator" ]]; then
	TERM=xterm-256color ;
elif [[ "x${WRAPPER_PROGRAM}" == "xtmux" ]]; then
	TERM=screen-256color ;
else
	LANG="en_US.UTF-8" ;
	export LANG ;
fi
export TERM
unset WRAPPER_PID WRAPPER_PROGRAM
fi


# other Linux-specific settings
if $is_linux; then
#export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# VDPAU by means of VAAPI, yeah!
VDPAU_DRIVER=va_gl
export VDPAU_DRIVER

# wayland, according to dev-libs/weston::x11
if [[ "x${XDG_RUNTIME_DIR}" == "x" ]]; then
	export XDG_RUNTIME_DIR=/tmp/.runtime-${USER}
	mkdir -p "${XDG_RUNTIME_DIR}"
	chmod 0700 "${XDG_RUNTIME_DIR}"
fi
fi

if ! $is_work; then
# added by travis gem
# only source if installed
if [[ -e ~/.travis/travis.sh ]]; then
	source ~/.travis/travis.sh
fi

# local NPM config
source ~/.config-local-npm.sh

# AFDKO
if [[ -e ~/.config-afdko.sh ]]; then
	source ~/.config-afdko.sh
fi
fi


# macOS-specific settings
if $is_darwin; then
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# install iTerm2 shell integration only if running in it
iterm2_integration_path=~/.iterm2_shell_integration.sh
if [[ -e $iterm2_integration_path && "x$TERM_PROGRAM" == "xiTerm.app" ]]; then
	source $iterm2_integration_path
fi

# homebrew ssh-agent
export SSH_AUTH_SOCK=~/.ssh-agent.sock
fi


# work-specific settings
# actually let's just enable them if installed, regardless of environment
if [[ -e ~/.gvm/scripts/gvm ]]; then
	# gvm
	source ~/.gvm/scripts/gvm
fi

# direnv
if command -v direnv > /dev/null 2>&1; then
	eval "$(direnv hook zsh)"
fi

if $is_darwin; then
	export NVM_DIR="$HOME/.nvm"
	. "/usr/local/opt/nvm/nvm.sh"
fi


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
