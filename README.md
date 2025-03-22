# dotfiles
## setup
```console
$ set -gx GIT_DIR "$HOME"/.dotfiles
$ set -gx GIT_WORK_TREE "$HOME"
$ git init --bare $HOME/.dotfiles # or git clone
$ git checkout -f main
$ git sparse-checkout set --no-cone "/*" "!README.md"
$ echo "*" >> $HOME/.dotfiles/info/exclude
```
