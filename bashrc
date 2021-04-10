#Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#Personal
alias analysis='source /home/users/aaarora/pyEnv/analysis/bin/activate; export PATH=/home/users/aaarora/pyEnv/analysis/bin/:$PATH'
alias jupnb='jupyter notebook --no-browser --port=9000'
alias niceplot='php ~/util/niceplots/index.php > ./index.html'
alias getp='kubectl get pods -n osg-gil -o wide'

#I'm Stupid
alias sl='ls'
alias sclear='clear'
alias clea='clear'
alias rls='ls'
alias vmi='vim'
alias vom='vim'

# Make CL Readable
export PS1='\e[0;33m\u@\h\w\$ \e[m\[\e]0;\u@\h:\w\a\]'

#CMSSW
source /cvmfs/cms.cern.ch/cmsset_default.sh
alias cmssw80='cwd=${PWD}; cd /cvmfs/cms.cern.ch/slc6_amd64_gcc530/cms/cmssw/CMSSW_8_0_25/; cmsenv; cd $cwd'
alias cmssw94='cwd=${PWD}; cd /cvmfs/cms.cern.ch/slc6_amd64_gcc630/cms/cmssw/CMSSW_9_4_1/src; cmsenv; cd $cwd'
alias cmssw1025='cwd=${PWD}; cd /cvmfs/cms.cern.ch/slc6_amd64_gcc700/cms/cmssw/CMSSW_10_2_5/src; cmsenv; cd $cwd'
alias cmssw10211='cwd=${PWD}; cd /cvmfs/cms.cern.ch/slc6_amd64_gcc700/cms/cmssw/CMSSW_10_2_11/src; cmsenv; cd $cwd'
alias cmssw10218='cwd=${PWD}; cd /cvmfs/cms.cern.ch/slc6_amd64_gcc700/cms/cmssw/CMSSW_10_2_18/src; cmsenv; cd $cwd; echo Now using CMSSW v10.2.18'
alias cmssw11107'=export SCRAM_ARCH=slc7_amd64_gcc820; cd /cvmfs/cms.cern.ch/$SCRAM_ARCH/cms/cmssw/CMSSW_11_1_7/src; eval `scramv1 runtime -sh`; cd - > /dev/null; echo Now using CMSSW v11.1.07'

#DQM
alias ev9='cd /cvmfs/cms.cern.ch/slc6_amd64_gcc530/cms/cmssw/CMSSW_9_2_8; cmsenv; cd -'
alias l="ls -lh --color=auto"
alias ll="ls -lh --color=auto"
alias lk="ls -lthrGH"

#Fix spelling errors for cd
shopt -s cdspell

#Make history more useful
export PROMPT_COMMAND="history -a"
export HISTSIZE=30000
export HISTFILESIZE=30000
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups

#eval $(dircolors -b ~/.dir_colors)

#Crab
export GLITE_VERSION="gLite-3.2.11-1"
export LCG_GFAL_INFOSYS=lcg-bdii.cern.ch:2170
export GLOBUS_TCP_PORT_RANGE=20000,25000

# git setup
git config --global user.name "aaarora"
git config --global user.email "aaarora@ucsd.edu"
git config --global alias.co checkout
git config --global alias.ci 'commit -a -m'
git config --global alias.pu 'push origin master'
git config --global alias.up 'pull origin master'
git config --global alias.unstage 'reset HEAD'

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#Load Python preferences
export PYTHONSTARTUP=$HOME/.pythonrc

export EDITOR="vim"

#use files in .local directory for locally installed programs/libraries
export PATH=$HOME/.local/bin:$HOME/sw/python/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$HOME/.local/lib64:$HOME/sw/python/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$C_INCLUDE_PATH:$HOME/.local/include
# export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/.local/include

export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig:$HOME/sw/python/lib/pkgconfig

# Custom functions
function clog {
    num=20
    # if number is less than 10k, then it can't be a condor_id, so
    # use it as the number of entries to show, otherwise use it
    # as condor_id
    if [ $# -gt 0 ]; then 
        num=$(echo $1 | sed 's/\..*//')
    fi
    if  [[ $# -gt 0 && "$num" -gt 10000 ]]; then
        jobid=$1
        info=$(condor_history  $jobid -limit 1 -af Iwd Out Err)
        iwd=$(echo $info | awk '{print $1}')
        out=$(echo $info | awk '{print $2}')
        err=$(echo $info | awk '{print $3}')
        [[ "$out" == "/"* ]] || out=${iwd}/${out}
        [[ "$err" == "/"* ]] || err=${iwd}/${err}
        echo $out
        echo $err
        vim -O $out $err  -c "normal G"
    else
        # condor_history $USER -limit 100
        condor_history $USER -limit $num
    fi
}

function mvpub(){
    mv $1 /home/users/aaarora/public_html/$2;
    chmod -R 755 /home/users/aaarora/public_html/$2;
}

function chpub(){
    chmod -R 755 $1
}

function execp() {
        kubectl exec -it $1 -n osg-gil -- bash
}

export -f execp
export -f mvpub
export -f chpub
