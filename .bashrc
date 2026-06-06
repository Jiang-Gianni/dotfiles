if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!.git"'
  export FZF_DEFAULT_OPTS='-m  --bind ctrl-q:select-all+accept'
fi

alias k=kubectl
alias n='nvim .'

# zsh
# PS1='%F{cyan}%1d $ %f'
# precmd() {print -Pn "\e]133;A\e\\" }

# bash
PS1='\[\033[01;36m\]\W \$\[\033[00m\] '
PROMPT_COMMAND='printf "\033]133;A\a\033]133;D;%s\a" $?'


gitdiff(){
    git diff origin/HEAD --name-only | fzf --preview 'git diff --word-diff -w  origin/HEAD -- {}' | xargs git difftool origin/HEAD
}

