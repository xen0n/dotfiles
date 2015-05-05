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

source $ZSH/oh-my-zsh.sh

# User configuration
#. /etc/profile

# set some alias
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias ls="ls --color=auto"
alias ll="ls -alF"

#alias grep="grep --color=auto"
#alias egrep="egrep --color=auto"

alias py="python"
alias py3="python3"
alias pyhttp="pypy -m SimpleHTTPServer"

alias enus="LANG=en_US.UTF-8"

alias weiyuactivate=". ~/kodez/exps/weiyutest/bin/activate"
alias rs="rain shell"

alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

# language...
#LANG=zh_CN.UTF-8

# dir_colors
eval `dircolors ~/.dir_colors`

# for ccache...
# also for adb
ANDROID_HOME="/var/android/android-sdk-linux"
ANDROID_JAVA_HOME="/opt/icedtea-bin-7.2.4.7"
ANDROID_NDK_HOME="/var/android/android-ndk"
ANDROID_BUILD_TOOLS_VERSION="22.0.1"

# Build PATH additions in reverse order.
#PATH="/usr/lib64/ccache/bin:${PATH}"
PATH="${ANDROID_HOME}/build-tools/${ANDROID_BUILD_TOOLS_VERSION}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools:${ANDROID_NDK_HOME}:${PATH}"
PATH="/home/xenon/.gem/ruby/2.0.0/bin:${PATH}"
PATH="/home/xenon/local/bin:${PATH}"

export PATH
export ANDROID_HOME
export ANDROID_JAVA_HOME
export ANDROID_NDK_HOME


# Detect term wrappers
#WRAPPER_PID="$( ps -o ppid --no-headers | head -1 | tr -d "[:blank:]" )"
WRAPPER_PID="$PPID"

if [[ "x${WRAPPER_PID}" != "x" ]]; then
	WRAPPER_PROGRAM="$( ps -p "${WRAPPER_PID}" -o comm --no-headers )" ;
else
	WRAPPER_PROGRAM="unknown" ;
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
	TERM=xterm-256color ;
else
	LANG="en_US.UTF-8" ;
	export LANG ;
fi
export TERM

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
