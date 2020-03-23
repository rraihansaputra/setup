# setup
setups

## brew

**Backup Brewfile**
```
brew bundle dump --force && cp Brewfile setup/Brewfile
```
**Cleanup Bundle before/after backing up**
```
brew bundle check  -verbose
brew bundle cleanup
```
**Restore from Brewfile**
```
brew bundle --file setup/Brewfile
```
**Link dotfiles**
```
ln -sv setup/.zshrc ~
ln -sv setup/.zsh_plugisns.txt ~
ln -sv setup/.config ~ # for karabiner and other stuff
ln -sv .vimrc
```
**Change default shell to Brew ZSH**
```
which zsh # should be /usr/local/bin/zsh..?
chsh -s /usr/local/bin/zsh
```

**Setup VSCodium with Settings Sync!!**
**Change iTerm2 to load settings from the ~/setup folder**

