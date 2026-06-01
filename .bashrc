if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!.git"'
  export FZF_DEFAULT_OPTS='-m  --bind ctrl-q:select-all+accept'
fi

alias k=kubectl

gbd(){
    git branch | grep --invert-match '\*' | cut -c 3- | fzf --multi --preview="git log {} --" | xargs --no-run-if-empty git branch --delete --force
}

gbs(){
    git branch | grep --invert-match '\*' | cut -c 3- | fzf --multi --preview="git log {} --" | xargs --no-run-if-empty git switch
}

gitdiff(){
    git diff main --name-only | fzf --preview 'git diff main -- {}' | xargs git difftool main
}

