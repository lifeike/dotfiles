# Feeco Dotfiles


## Init Chezmoi on new device
```
  sudo snap install chezmoi --classic && chezmoi init --apply lifeike 
```
## Commands
```
alias update-dotfiles='chezmoi re-add'
alias sync-dotfiles='chezmoi update'
alias cd-dotfiles='cd ~/.local/share/chezmoi && ranger'
alias add-dotfiles='chezmoi add'
alias cs='chezmoi status'
```
