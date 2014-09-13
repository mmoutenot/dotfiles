# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme bobthefish

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
set fish_plugins autojump brew bundler python rails rake

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish cofiguration.
. $fish_path/oh-my-fish.fish

set PATH $HOME/.rbenv/bin $PATH
status --is-interactive; and . (rbenv init -|psub)
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# aliases
. ~/.aliases

