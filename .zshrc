export LD_LIBRARY_PATH=/opt/local/lib
#/bin/bash
#shell-variable
DIRSTACKSIZE=10
fignore=(.o \~)
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
fpath=(~/myfunc $fpath)
#zstyle
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# eval `dircolors`
LSCOLORS=fxexcxdxbxegedabagacad
#zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}
zstyle ':completion:*' list-colors di=34 ln=35 ex=31

#autoload
autoload -U compinit
compinit

autoload -U colors
colors

autoload history-search-end

[ -n "`alias run-help`" ] && unalias run-help
autoload run-help

autoload ${fpath[1]}/*(:t)

#zle
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#alias
alias emacs='/Applications/Emacs.app/Contents/MacOS/EMacs -nw'
alias p='print'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias -g G='| grep'
alias -g L='| less'
alias ll='ls -l -F -G'
alias ls='ls -F -G'
alias alist='alias -L'
alias dirs='dirs -v'
#options
#--i&o--#
setopt ignore_eof
setopt no_clobber
setopt sun_keyboard_hack
#history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_ignore_space
#completion
#filename
setopt extended_glob
setopt numeric_glob_sort
unsetopt nomatch
#directory
setopt auto_cd
setopt auto_pushd
#bindkey
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^D" delete-char
bindkey "^H" backward-delete-char
bindkey "^Z" undo
bindkey "^O" insert-last-word
bindkey "^J" push-line
bindkey "^'" quote-line
#prompt
PS1="%{${fg[cyan]}%}%n%{${fg[default]}%} %#"
RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%}"
SPROMPT="%{${fg[green]}%}zsh: correct '%R' to '%r' [nyae]?%{${fg[default]}%} "
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

#history
SAVEHIST=100000
HISTSIZE=100000
HISTFILE=~/.zhistory

function getDefaultBrowser() {
    preffile=$HOME/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure
    if [ ! -f ${preffile}.plist ]; then
        preffile=$HOME/Library/Preferences/com.apple.LaunchServices
    fi
    # browser might be "com.apple.safari", "org.mozilla.firefox" or "com.google.chrome".
    browser=$(defaults read ${preffile} | grep -B 1 "https" | awk '/LSHandlerRoleAll/{ print $NF }' | sed -e 's/"//g;s/;//')
}

function gitblit() {
    nsip=$(host fun.bio.keio.ac.jp | head -1 | awk '{print $4}')
    browser=$(getDefaultBrowser)
    if [ ${browser} = "com.google.chrome" ]; then
        browser="org.mozilla.firefox"
    fi
    if [ ${nsip} = 192.168.11.2 ]; then
        # in FUNALAB private network
        open -b ${browser} http://fun.bio.keio.ac.jp:8080
    else
        # outside FUNALAB
        open -b org.mozilla.firefox https://fun.bio.keio.ac.jp:8443
    fi
    unset nsip
    unset browser
    }


cat /Users/nishimoto/mygo/ansize/donkey.ansi
#
# Goolge Search by Google Chrome
#
google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            # $strが空じゃない場合、検索ワードを+記号でつなぐ(and検索)
            str="$str${str:++}$i"
        done
        opt='search?num=100'
        opt="${opt}&q=${str}"
    fi
    open -a Google\ Chrome http://www.google.co.jp/$opt
    }


# alias ll='say hello'
