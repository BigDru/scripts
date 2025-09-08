#!/bin/bash
path_to_repos="/home/dru/repos"
path_to_work="/home/dru/work"
path_to_dropbox="/mnt/c/Users/aldum/Dropbox"

export path_to_repos

mkdir -p ${path_to_repos}

./git_update.sh

# DOTFILES
git clone git@github.com:BigDru/dotfiles.git ${path_to_repos}/dotfiles

touch ~/.bashrc_dru
echo "export path_to_repos=\"${path_to_repos}\"" >> ~/.bashrc_dru

ln -sf ${path_to_repos}/dotfiles/.bashrc ~/.bashrc
ln -sf ${path_to_repos}/dotfiles/.dircolors ~/.dircolors
ln -sf ${path_to_repos}/dotfiles/.gitconfig ~/.gitconfig
ln -sf ${path_to_repos}/dotfiles/.tmux.conf ~/.tmux.conf

source ~/.bashrc

#neovim
./nvim_install.sh

mkdir -p ~/.config
ln -sf ${path_to_repos}/dotfiles/.config/nvim ~/.config/nvim

# misc
mkdir ~/bin

mkdir -p ${path_to_work}
ln -s {path_to_dropbox} ${path_to_work}/dropbox
ln -s {path_to_dropbox}/Dev ${path_to_work}/dev
