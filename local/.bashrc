# source global definitions
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# aliases
source ~/.aliases

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