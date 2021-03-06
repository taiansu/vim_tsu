#!/bin/sh
VIMHOME=~/.vim
LOCAL_NAME=vimrc
VIM_DIR=$(printf "%s/%s/vim" $(pwd) $LOCAL_NAME)
VIMRC=$(printf "%s/%s/vimrc" $(pwd) $LOCAL_NAME)
GVIMRC=$(printf "%s/%s/gvimrc" $(pwd) $LOCAL_NAME)

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

[ -e "$VIMHOME" ] && die "$VIMHOME already exists."
[ -e "~/.vimrc" ] && die "~/.vimrc already exists."

# Link folder and files
cd ~
ln -s $VIM_DIR $VIMHOME
ln -s $VIMRC .vimrc
ln -s $GVIMRC .gvimrc

cd $VIMHOME
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -n -c "set nomore" +PlugUpgrade +PlugInstall +qall

echo "Your own vim is ready to use. Happy Hacking～"
