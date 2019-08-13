# Based on http://stackoverflow.com/a/32164707/3859566
function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%dd' $D
  [[ $H > 0 ]] && printf '%dh' $H
  [[ $M > 0 ]] && printf '%dm' $M
  printf '%ds' $S
}

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}


# COMMAND EXECUTION TIME
preexec() {
  cmd_timestamp=`date +%s`
}

precmd() {
  local stop=`date +%s`
  local start=${cmd_timestamp:-$stop}
  let last_exec_duration=$stop-$start
  cmd_timestamp=''
}

prompt_last_exec_duration() {
  echo "%{$fg[green]%}$(displaytime $last_exec_duration)"
}

prompt_ret_code() {
  echo " [$?] "
}

# Get the host name (first 4 chars)
TIME_PROMPT="%{$fg[yellow]%}%D{%T}"
HOST_PROMPT_="%{$fg_bold[red]%}@$HOST ➜ %{$fg_bold[cyan]%}%3c "
GIT_PROMPT="%{$fg_bold[blue]%}\$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}"
EXEC_TIME_PROMPT="\$(prompt_last_exec_duration)"
RET_CODE_PROMPT="\$(prompt_ret_code)"
PROMPT=''
PROMPT="$PROMPT""$TIME_PROMPT$RET_CODE_PROMPT$HOST_PROMPT_$GIT_PROMPT$EXEC_TIME_PROMPT"
#PROMPT="$PROMPT"'%{%f%b%k%}$(build_exec_time)'
PROMPT="$PROMPT"" %{%k%F{white}%}& "

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Prompt previous command execution time
preexec() {
  cmd_timestamp=`date +%s`
}
