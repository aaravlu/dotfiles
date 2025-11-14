unset HISTFILE
PROMPT_COMMAND='[[ "$PWD" == "$HOME" ]] && PS1="\h~\u> " || PS1="\h|\u> "'

pwd() {
    [ "$PWD" != "$HOME" ] && builtin pwd
}
cd() {
    builtin cd "$@"
    builtin pwd
}

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias fetch=macchina
alias ll="ls -l --time-style=iso"
