#!/bin/bash

export PATH=/opt/homebrew/bin:$PATH

# aliases
alias ping=prettyping
## git
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gdc="git diff -- . ':!package-lock.json'"

. /opt/homebrew/opt/asdf/libexec/asdf.sh
. /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
