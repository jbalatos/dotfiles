# DOTFILES
## Create New Bare Repository

    cd
    git init --bare $HOME/.cfg
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    config config --local status.showUntrackedFiles no
    echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
    echo '.cfg' >> .gitignore

## Clone Current Repository

    cd
    git clone --bare https://github.com/jbalatos/dotfiles.git $HOME/.cfg
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    config checkout
    config config --local status.showUntrackedFiles no

