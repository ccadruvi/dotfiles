# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

function k8s_cluster {
  if command -v kubectl &>/dev/null; then
    current_context=$(kubectl config current-context 2>&1)
    if [[ $current_context == "error: current-context is not set" ]]; then
      kubectl config view -o json --minify | jq -r .contexts[0].context.cluster
    else
      echo "N/A"
    fi
  else
    echo "N/A"
  fi
}
function k8s_namespace {
  if command -v kubectl &>/dev/null; then
    current_context=$(kubectl config current-context 2>&1)
    if [[ $current_context == "error: current-context is not set" ]]; then
      kubectl config view -o json --minify | jq -r .contexts[0].context.namespace
    else
      echo "N/A"
    fi
  else
    echo "N/A"
  fi
}
RETURN="\$(ret=\$?; if [[ \$ret = 0 ]];then echo \"\[\033[01;32m\]✓\";else echo \"\[\033[01;91m\]\$ret\";fi)\[\033[00m\]"
GREEN="\[\033[01;92m\]"
BLUE="\[\033[01;94m\]"
ORANGE="\[\033[01;93m\]"
WHITE="\[\033[00m\]"
PROMPT_COMMAND='k8s_cluster=$(k8s_cluster);k8s_namespace=$(k8s_namespace);$(history -a);
PS1="$ORANGE\$k8s_cluster:$k8s_namespace$WHITE:$BLUE\w$WHITE $RETURN \$ ";'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto' 
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

SECTIONS="aliases functions options"
for section in $SECTIONS ; do
	if [ -d "$HOME/.bash/$section" ] ; then
		for source_file in $(find "$HOME/.bash/$section" -type f -iname "*.sh" | sort) ; do
			source "$source_file"
		done
	fi
done

if command -v thefuck &>/dev/null; then
  eval "$(thefuck --alias)"
fi
alias vim='vim +"set number"'

LS_COLORS='rs=0:di=01;34;40:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;40:ow=34;40:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

alias di='docker images'
alias dia='docker images -a'
alias fd='fdfind'
alias fernseh='flatpak run org.gnome.NetworkDisplays'

if command -v kubectl &>/dev/null; then
  source <(kubectl completion bash)
fi


DOTFILES_DIR="$HOME/git/dotfiles"
rm -rf "$HOME/.bash"
cp -r "$DOTFILES_DIR/bash" "$HOME/.bash"
cp -r "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
cp -r "$DOTFILES_DIR/complete_alias" "$HOME/complete_alias"

source "$HOME/complete_alias"

# source options aliases completions and functions
SECTIONS="options aliases completions functions"
for section in $SECTIONS ; do
	if [ -d "$HOME/.bash/$section" ] ; then
		for source_file in $(find "$HOME/.bash/$section" -type f -iname "*.sh" | sort) ; do
			source "$source_file"
		done
	fi
done

if [[ -f $HOME/.ssh/azure_devops_christian_cadruvi ]]; then
  ssh-add  $HOME/.ssh/azure_devops_christian_cadruvi > /dev/null 2>&1
fi

# new gcloud gke auth plugin
USE_GKE_GCLOUD_AUTH_PLUGIN=True

export PATH=$PATH:~/.kubectx
# thefuck alias
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/go/bin
export GOSRC=~/go/src/dev.azure.com/digitecgalaxus/SystemEngineering
