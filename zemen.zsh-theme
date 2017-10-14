local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

if [[ -z "$SSH_CLIENT" && $UID != 0 ]]; then
  HOST=""
else
  if [[ $UID == 0 ]]; then
    COL="red"
  else
    COL="green"
  fi
  HOST="%{$fg_bold[$COL]%}[%n@$(hostname -s)] "
fi

PROMPT='${ret_status}${HOST}%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
