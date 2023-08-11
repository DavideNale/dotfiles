if status is-interactive
    # Commands to run in interactive sessions can go here
end

# mambaforge
source "/opt/mambaforge/etc/fish/conf.d/conda.fish"

# custom additions
set fish_greeting
starship init fish | source

# dotfile alias
alias dots='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# aliases
alias hx=helix
alias py=python
alias gg=git-graph
alias ls=exa
alias cc='cd (fd -H -d 5 -c always --type directory | fzf --ansi --layout reverse --tiebreak length,chunk)'