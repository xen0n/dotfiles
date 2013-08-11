# /etc/profile: login shell setup
#
# That this file is used by any Bourne-shell derivative to setup the
# environment for login shells.
#

# Load environment settings from profile.env, which is created by
# env-update from the files in /etc/env.d
if [ -e /etc/profile.env ] ; then
	. /etc/profile.env
fi

# You should override these in your ~/.bashrc (or equivalent) for per-user
# settings.  For system defaults, you can add a new file in /etc/profile.d/.
export EDITOR=${EDITOR:-/bin/nano}
export PAGER=${PAGER:-/usr/bin/less}

# 077 would be more secure, but 022 is generally quite realistic
umask 022

# Set up PATH depending on whether we're root or a normal user.
# There's no real reason to exclude sbin paths from the normal user,
# but it can make tab-completion easier when they aren't in the
# user's PATH to pollute the executable namespace.
#
# It is intentional in the following line to use || instead of -o.
# This way the evaluation can be short-circuited and calling whoami is
# avoided.
if [ "$EUID" = "0" ] || [ "$USER" = "root" ] ; then
	PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${ROOTPATH}"
else
	PATH="/usr/local/bin:/usr/bin:/bin:${PATH}"
fi
export PATH
unset ROOTPATH

if [ -n "${BASH_VERSION}" ] ; then
	# Newer bash ebuilds include /etc/bash/bashrc which will setup PS1
	# including color.  We leave out color here because not all
	# terminals support it.
	if [ -f /etc/bash/bashrc ] ; then
		# Bash login shells run only /etc/profile
		# Bash non-login shells run only /etc/bash/bashrc
		# Since we want to run /etc/bash/bashrc regardless, we source it 
		# from here.  It is unfortunate that there is no way to do 
		# this *after* the user's .bash_profile runs (without putting 
		# it in the user's dot-files), but it shouldn't make any 
		# difference.
		. /etc/bash/bashrc
	else
		PS1='\u@\h \w \$ '
	fi
else
	# Setup a bland default prompt.  Since this prompt should be useable
	# on color and non-color terminals, as well as shells that don't
	# understand sequences such as \h, don't put anything special in it.
	PS1="${USER:-$(whoami 2>/dev/null)}@$(uname -n 2>/dev/null) \$ "
fi

for sh in /etc/profile.d/*.sh ; do
	[ -r "$sh" ] && . "$sh"
done
unset sh

# xenon 20120502: open files limit
ulimit -SHn 131072

# xenon 20120602: PS1 customization
# xenon 20130609: enable Git prompt if applicable, also detecting color
# according to /etc/bash/bashrc
use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

__HAVE_GIT_PS1=false
type __git_ps1 > /dev/null 2>&1 && __HAVE_GIT_PS1=true

if ${__HAVE_GIT_PS1}; then
	# do nothing
	true ;
else
	# try to load git prompt
	_path=/usr/share/bash-completion/completions/git-prompt
	[ -e "${_path}" ] && . "${_path}"
	unset _path
	type __git_ps1 > /dev/null 2>&1 && __HAVE_GIT_PS1=true
fi

if ${__HAVE_GIT_PS1}; then
	if ${use_color}; then
		# Use different color for root
		if [ "$EUID" = "0" ] || [ "$USER" = "root" ] ; then
			__DATE_COLOR='01;32'
			__GIT_COLOR='01;33'
		else
			__DATE_COLOR='01;33'
			__GIT_COLOR='01;37'
		fi

		PS1="# \[\033[${__DATE_COLOR}m\][\D{%m/%d %H:%M:%S}]\[\033[00m\] ${PS1}\$(__git_ps1 \"\[\033[${__GIT_COLOR}m\](%s)\[\033[00m\]\")\n"
		unset __DATE_COLOR __GIT_COLOR
	else
		PS1="# [\D{%m/%d %H:%M:%S}] ${PS1}\$(__git_ps1 \"(%s)\")\n"
	fi
else
	PS1="# [\D{%m/%d %H:%M:%S}] ${PS1}\n"
fi

unset safe_term match_lhs use_color __HAVE_GIT_PS1
