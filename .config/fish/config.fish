if status is-interactive
    # Commands to run in interactive sessions can go here
end

# custom additions
set fish_greeting
starship init fish | source

# dotfile alias
alias dots='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# aliases
alias hx=helix
alias vim=nvim
alias py=python
alias gg=git-graph
alias ls=exa
alias mamba=micromamba
alias cc='cd (fd -H -d 5 -c always --type directory | fzf --ansi --layout reverse --tiebreak length,chunk)'
