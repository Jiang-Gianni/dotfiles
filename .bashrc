if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!.git"'
  export FZF_DEFAULT_OPTS='-m  --bind ctrl-q:select-all+accept'
fi

alias k=kubectl
alias n='nvim .'

gitdiff(){
    git diff main --name-only | fzf --preview 'git diff --word-diff -w  main -- {}' | xargs git difftool main
}

