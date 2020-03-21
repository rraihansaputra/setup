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
