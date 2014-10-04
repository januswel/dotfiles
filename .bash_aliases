# .bash_aliases
# sourced by .bashrc

LS_COMMAND="ls"
CP_COMMAND="cp"
MV_COMMAND="mv"
RM_COMMAND="rm"
DIRCOLORS_COMMAND="dircolors"

if [ "Darwin" = $(uname) ]; then
    LS_COMMAND="gls"
    CP_COMMAND="gcp"
    MV_COMMAND="gmv"
    RM_COMMAND="grm"
    DIRCOLORS_COMMAND="gdircolors"
fi

# aliases
alias ls="$LS_COMMAND --color=auto"
alias cp="$CP_COMMAND -i"
alias mv="$MV_COMMAND -i"
alias rm="$RM_COMMAND -i"
alias dircolors="$DIRCOLORS_COMMAND"

# vim: ts=4 sw=4 sts=0 et ft=sh
