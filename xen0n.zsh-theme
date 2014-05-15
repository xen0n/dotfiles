local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%}%s)#"

local right_retcode="%(?..%{$fg_bold[red]%}%? ↵  %{$reset_color%})"

local userhost

if [[ -n "${SSH_CLIENT}" ]]; then
  userhost=" %{$fg[green]%}%n@%m"
else
  userhost=""
fi

local time_sign="⌚"

path_sign () {
  git branch >/dev/null 2>/dev/null && echo "%{$fg_bold[magenta]%}±" && return
  hg root >/dev/null 2>/dev/null && echo "%{$fg_bold[magenta]%}☿" && return
  echo "%{$fg[blue]%}↯"
}

time_seg () {
  echo " %{$fg[yellow]%}${time_sign} %*"
}
path_seg () {
  #echo " $(path_sign) %{$fg[blue]%}%~"
  echo " $(path_sign) %{$fg[blue]%}${PWD/#$HOME/~}"
}

PROMPT='${ret_status}$(time_seg)${userhost}$(path_seg)%{$reset_color%}
'
RPROMPT='${right_retcode}$(git_prompt_info)%{%b$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%} %{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""


# vim:set ai et ts=2 sw=2 sts=2 ft=zsh fenc=utf-8:
