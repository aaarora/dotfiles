# source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# fix spelling errors for cd
shopt -s cdspell
eval $(dircolors)

source ~/.aliases

export PS1='[$(date +%H%M)] \u@\h \W\$ '

# make history more useful
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
export HISTSIZE=30000
export HISTFILESIZE=30000
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups

# lang setup
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# kubernetes
export KUBECONFIG=~/.kube/config.dev

# set default editor for sudoedit
export EDITOR="vim"

# custom functions
# ssh-agent
function sshagent {
  eval $(ssh-agent -s) &> /dev/null
  find ~/.ssh/ -type f -exec grep -l "PRIVATE" {} \; | xargs ssh-add &> /dev/null
}
# mv file/dir to public_html
function cppub {
  cp -r $1 $HOME/public_html/$2;
  chmod -R 755 $HOME/public_html/$2;
  echo "Moved to $HOME/public_html/$2"
}
# change file/dir perm to 755
function chpub {
  chmod -R 755 $1
}
function kill-all {
  for i in $(ps aux | grep aaarora | grep $1 | awk '{print $2}'); do
    kill -9 $i;
  done
}
# kubernetes shell exec alias
function execp {
  if [ -z "$2" ]; then
    kubectl exec -it $1 -- bash
  else
    kubectl exec -it $1 -n $2 -- bash
  fi
}
# mv to recycle bin
function trash {
if [ -d "$HOME/.trash" ]; then
  mv "$@" $HOME/.trash
fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/users/aaarora/.miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/users/aaarora/.miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/users/aaarora/.miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/users/aaarora/.miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
