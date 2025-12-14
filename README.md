# Feeco Dotfiles


## Init Chezmoi on new device
```
sudo snap install chezmoi --classic && chezmoi init --apply lifeike 
```

## Commands
```
alias updatedotfiles='chezmoi re-add'
alias syncdotfiles='chezmoi update'
alias cddotfiles='cd ~/.local/share/chezmoi && ranger'
alias adddotfiles='chezmoi add'
alias cs='chezmoi status'
```
