Welcome to my Arch Linux configuration with the Hyprland window manager. This repository contains my personal dotfiles and configuration settings to set up my ideal Arch Linux desktop environment.

![](.screenshots/system.png)

![](.screenshots/code.png)

This repo is managed as a `bare repo` and referenced by an alias. Its important to set `showUntrackerFiles` to false, not to be overwhelmed.

```bash
# dotfiles alias
alias dots='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# settings of the .dotfiles bare repo
dots config --local status.showUntrackedFiles no
```