# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

# for bashcomp
. /etc/profile


# set some alias
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias ls="ls --color=auto"
alias ll="ls -alF"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

alias py="python"
alias py3="python3"
alias pyhttp="pypy-c2.0 -m SimpleHTTPServer"

alias enus="LANG=en_US.UTF-8"

alias weiyuactivate=". ~/kodez/exps/weiyutest/bin/activate"
alias rs="rain shell"

# language...
#LANG=zh_CN.UTF-8

# for ccache...
# also for adb
ANDROID_HOME="/opt/android/android-sdk-linux"
ANDROID_JAVA_HOME="/opt/icedtea-bin-6.1.12.5"
ANDROID_NDK_HOME="/opt/android/android-ndk-r9"

# Build PATH additions in reverse order.
#PATH="/usr/lib64/ccache/bin:${PATH}"
PATH="${ANDROID_HOME}/build-tools/18.1.0:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools:${ANDROID_NDK_HOME}:${PATH}"
PATH="/home/xenon/.gem/ruby/2.0.0/bin:${PATH}"
PATH="/home/xenon/local/bin:${PATH}"

export PATH
export ANDROID_HOME
export ANDROID_JAVA_HOME
export ANDROID_NDK_HOME


# PS1
#PS1="[$(date '+%Y-%m-%d %H:%M:%S')] ${PS1}"
# PS1="[\D{%m/%d %H:%M:%S}] ${PS1}"


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
export XDG_RUNTIME_DIR=/tmp/.runtime-${USER}
mkdir -p "${XDG_RUNTIME_DIR}"
chmod 0700 "${XDG_RUNTIME_DIR}"

# added by travis gem
source /home/xenon/.travis/travis.sh

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end
