# /etc/bashrc

# System wide functions and aliases
# Environment stuff goes in /etc/profile

# It's NOT a good idea to change this file unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to your environment, as this
# will prevent the need for merging in future updates.

# Prevent doublesourcing
if [ -z "$BASHRCSOURCED" ]; then
    BASHRCSOURCED="Y"

    # are we an interactive shell?
    if [ "$PS1" ]; then
        if [ -z "$PROMPT_COMMAND" ]; then
            case $TERM in
                xterm*|vte*)
                    if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
                        PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
                    # eliminate for Sandbox VTE issues
                    #    elif [ "${VTE_VERSION:-0}" -ge 3405 ]; then 
                    #     PROMPT_COMMAND="__vte_prompt_command"
                    else
                        PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
        fi
        ;;
      screen*)
        if [ -e /etc/sysconfig/bash-prompt-screen ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
        else
            PROMPT_COMMAND='printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
        fi
        ;;
      *)
        [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
        ;;
      esac
    fi
    # Turn on parallel history
    shopt -s histappend
    history -a
    # Turn on checkwinsize
    shopt -s checkwinsize
    [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
    # You might want to have e.g. tty in prompt (e.g. more virtual machines)
    # and console windows
    # If you want to do so, just add e.g.
    # if [ "$PS1" ]; then
    #   PS1="[\u@\h:\l \W]\\$ "
    # fi
    # to your custom modification shell script in /etc/profile.d/ directory
  fi

  if ! shopt -q login_shell ; then # We're not a login shell
    # Need to redefine pathmunge, it gets undefined at the end of /etc/profile
    pathmunge () {
        case ":${PATH}:" in
            *:"$1":*)
                ;;
            *)
                if [ "$2" = "after" ] ; then
                    PATH=$PATH:$1
                else
                    PATH=$1:$PATH
                fi
        esac
    }

    # By default, we want umask to get set. This sets it for non-login shell.
    # Current threshold for system reserved uid/gids is 200
    # You could check uidgid reservation validity in
    # /usr/share/doc/setup-*/uidgid file
    if [ $UID -gt 199 ] && [ "`id -gn`" = "`id -un`" ]; then
       umask 002
    else
       umask 022
    fi

    SHELL=/bin/bash
    # Only display echos from profile.d scripts if we are no login shell
    # and interactive - otherwise just process them to set envvars
    for i in /etc/profile.d/*.sh; do
        if [ -r "$i" ]; then
            if [ "$PS1" ]; then
                . "$i"
            else
                . "$i" >/dev/null
            fi
        fi
    done

    unset i
    unset -f pathmunge
  fi

fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
if [ "$(command -v clang)" >/dev/null 2>&1 ];
then
    alias clang='clang -fcolor-diagnostics -Weverything'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Show the currently running command in the terminal title:
update_tab_command()
    {
        # catch blacklisted commands and nested escapes
        case "$BASH_COMMAND" in
            *\033]0*|update_*|echo*|printf*|clear*|cd*)
            __el_LAST_EXECUTED_COMMAND=""
                ;;
            *)
            put_title "${BASH_COMMAND}"
            ;;
        esac
        return 0
    }
preexec_functions+=(update_tab_command)

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# User specific environment and startup programs

if [ -d "$HOME/.local/bin" ] && [ -d "$HOME/.local/lib64/" ] \
    && [ "$(command -v clear)" >/dev/null 2>&1 ]; 
then
    export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:$HOME/.local/bin \
        && export LD_LIBRARY_PATH=$HOME/.local/lib64/
fi

if [ -x "$(command -v ccache)" 2>&1 >/dev/null ];
then
  export PATH=/usr/lib64/ccache:$PATH
fi

# VLC Wayland Fix
if [ "$XDG_SESSION_TYPE" == "wayland" ];
then
  export QT_QPA_PLATFORM=wayland
fi

# tmux color fix
if [ "$TERM" == "xterm-256color" ];
then
    export TERM=xterm-256color
fi

# Vi executes vim (if vim exists)
if [ -x "$(command -v vim)" >/dev/null 2>&1 ];
then
    alias vi='vim'
fi

# Default Editor
if [ -x "$(command -v vim)" >/dev/null 2>&1 ];
then
    export EDITOR='vim'
elif [ -x "$(command -v emacs)" >/dev/null 2>&1 ];
then
    export EDITOR='emacs -nw'; 
    alias emacs='emacs -nw'
else
    export EDITOR='vi'
fi


if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    if [[ $ID = arch ]];
    then
        alias news="curl -s https://www.archlinux.org/feeds/news/ | xmllint --xpath //item/title\ \|\ //item/pubDate /dev/stdin | sed -r -e 's:<title>([^<]*?)</title><pubDate>([^<]*?)</pubDate>:\2\t\1\n:g'"
    fi
fi

# setting Qt5 uniform look for GTK+
export QT_QPA_PLATFORMTHEME=gtk2

# git support in bash
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}

function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

# color prompt
PS1="\[\e[0;33m\]\u\[\e[0m\]\[\e[0;36m\]@\[\e[m\]\[\e[36m\]\h\[\e[0m\]\[\e[32m\]:\[\e[m\] \[\e[31m\]\w\[\e[m\] \[\e[31m\]\[\e[m\]\[\e[31m\]\\$\[\e[33m\]\`parse_git_branch\`\[\e[m\] "
SUDO_PS1="\[\e[0;33m\]\u\[\e[0m\]\[\e[0;36m\]@\[\e[m\]\[\e[36m\]\h\[\e[0m\]\[\e[32m\]:\[\e[m\] \[\e[32m\]\w\[\e[m\] \[\e[31m\]\[\e[m\]\[\e[31m\]\\$\[\e[31m\]\`parse_git_branch\`\[\e[m\] "

# dmesg human readable dates
#alias dmesg="dmesg -T|sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'"

# Notification Popups (manual)
if [ -c "$(command -v notify-send)" >/dev/null 2>&1 ];
then
    alias notify='notify-send --urgency=low -i "$([ $? = 0 ] && (echo terminal; exit 0) || (echo error; exit 1))" "$([ $? = 0 ] && echo Task finished || echo Something went wrong!)" "$(history | sed -n "\$s/^\s*[0-9]\+\s*\(.*\)[;&|]\s*notify\$/\1/p")"'
fi

# youtube-dl title name fix
if [ "$(command -v youtube-dl)" >/dev/null 2>&1 ];
then
    alias youtube-dl="youtube-dl -o '%(title)s.%(ext)s'"
fi

# Golang completion
function _go() {
  cur="${COMP_WORDS[COMP_CWORD]}"
  case "${COMP_WORDS[COMP_CWORD-1]}" in
    "go")
      comms="build clean doc env bug fix fmt generate get install list run test tool version vet"
      COMPREPLY=($(compgen -W "${comms}" -- ${cur}))
      ;;
    *)
      files=$(find ${PWD} -mindepth 1 -maxdepth 1 -type f -iname "*.go" -exec basename {} \;)
      dirs=$(find ${PWD} -mindepth 1 -maxdepth 1 -type d -not -name ".*" -exec basename {} \;)
      repl="${files} ${dirs}"
      COMPREPLY=($(compgen -W "${repl}" -- ${cur}))
      ;;
  esac
  return 0
}

complete -F _go go

# vim:ts=4:sw=4
