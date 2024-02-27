if status is-interactive
    # Commands to run in interactive sessions can go here
end

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/usr/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/home/davide/micromamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<

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

