# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme bobthefish

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
set fish_plugins brew bundler python rails node tmux vi-mode

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/oh-my-fish

set PATH /usr/local/bin:/usr/local/sbin:$PATH
set PATH /usr/local/lib/python2.7/site-packages:$PATH
set PYTHONPATH /usr/local/lib/python2.7/site-packages

# Load oh-my-fish cofiguration.
. $fish_path/oh-my-fish.fish

# set -gx RBENV_ROOT /usr/local/var/rbenv
# . (rbenv init -|psub)

# aliases
. ~/.aliases

