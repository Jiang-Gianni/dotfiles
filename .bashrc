if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!.git"'
  export FZF_DEFAULT_OPTS='-m  --bind ctrl-q:select-all+accept'
fi

alias k=kubectl
alias n='nvim .'

# zsh
# PS1='%1d $ '
# precmd() {print -Pn "\e]133;A\e\\" }

# bash
PS1='\W \$ '
PROMPT_COMMAND='printf "\033]133;A\a\033]133;D;%s\a" $?'


gitdiff(){
    git diff main --name-only | fzf --preview 'git diff --word-diff -w  main -- {}' | xargs git difftool main
}

