# source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ssh aliases
alias uaf10='ssh aaarora@uaf-10.t2.ucsd.edu'
alias uaf8='ssh aaarora@uaf-8.t2.ucsd.edu'
alias uaf7='ssh aaarora@uaf-7.t2.ucsd.edu'
alias uaf1='ssh aaarora@uaf-1.t2.ucsd.edu'
alias t07='ssh aaarora@test-007.t2.ucsd.edu'
alias Xuaf1='ssh -X aaarora@uaf-1.t2.ucsd.edu'
alias rasp='ssh -p 42000 aashay@pi.aashayarora.com'
alias killsshfs='sudo umount ~/Work/uaf'

# docker
alias sandbox='docker run --rm -it sandbox bash'
alias docker-stop-all='docker stop $(docker ps -aq)'
alias docker-remove-all='docker rm $(docker ps -aq)'
alias docker-cleanup='docker rm $(docker ps -aq); docker system prune -f --volumes'
alias k='kubectl'

# ls aliases
alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"

alias rm="rm -i"

function sshfsuaf {
  sshfs aaarora@uaf-8.t2.ucsd.edu:/home/users/aaarora/$1 /home/aashay/Work/uaf
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PS1="\[\033]0;\u: \w\007\]$PS1"

# lang setup
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# set default editor for sudoedit
export EDITOR="vim"

export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
export HISTSIZE=30000
export HISTFILESIZE=30000
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups

# git setup
if [ ! -f ~/.gitconfig ]; then
  git config --global user.name "aaarora"
  git config --global user.email "aaarora@ucsd.edu"
  git config --global alias.co checkout
  git config --global alias.ci 'commit -a -m'
  git config --global alias.pu 'push origin master'
  git config --global alias.up 'pull origin master'
  git config --global alias.fe 'fetch upstream'
  git config --global alias.re 'rebase upstream/master'
  git config --global alias.unstage 'reset HEAD'
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/aashay/.miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/aashay/.miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/aashay/.miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/aashay/.miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

