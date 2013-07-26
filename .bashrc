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


# language...
#LANG=zh_CN.UTF-8

# for ccache...
# also for adb
#PATH="/home/xenon/local/bin:/usr/lib64/ccache/bin:/opt/android/android-sdk-linux/build-tools/17.0.0:/opt/android/android-sdk-linux/platform-tools:/opt/android/android-sdk-linux/tools:${PATH}"
PATH="/home/xenon/local/bin:/opt/android/android-sdk-linux/build-tools/17.0.0:/opt/android/android-sdk-linux/platform-tools:/opt/android/android-sdk-linux/tools:${PATH}"
ANDROID_HOME="/opt/android/android-sdk-linux"
ANDROID_JAVA_HOME="/opt/icedtea-bin-6.1.12.5"

export PATH
export ANDROID_HOME
export ANDROID_JAVA_HOME

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
