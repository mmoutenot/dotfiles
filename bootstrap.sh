#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
# git pull origin master
function doIt() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
    --exclude "README.md" --exclude "LICENSE-MIT.txt" -av --no-perms . ~
  . ~/.config/fish/config.fish

  git config --global core.excludesfile ~/.gitignore_global

  sh .brew

  # install bundle and vim bundles
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim -E -c PluginInstall -c q

  # install oh-my-fish
  curl -L https://github.com/bpinto/oh-my-fish/raw/master/tools/install.fish | fish
  grep -q '^/usr/local/bin/fish$' /etc/shells ||echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/fish

  sh .osx
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt
