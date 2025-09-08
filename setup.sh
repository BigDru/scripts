#!/bin/bash
path_to_repos="/home/dru/repos"
path_to_work="/home/dru/work"

export path_to_repos

mkdir -p ${path_to_repos}

./git_update.sh

# DOTFILES
git clone git@github.com:BigDru/dotfiles.git ${path_to_repos}/dotfiles

touch ~/.bashrc_dru
echo export path_to_repos="${path_to_repos}" >> ~/.bashrc_dru

source .bashrc

ln -s ~/.bashrc ${path_to_repos}/dotfiles/.bashrc
ln -s ~/.dircolors ${path_to_repos}/dotfiles/.dircolors
ln -s ~/.gitconfig ${path_to_repos}/dotfiles/.gitconfig
ln -s ~/.tmux.conf ${path_to_repos}/dotfiles/.tmux.conf


#neovim
./nvim_install.sh

ln -s ~/.config/nvim ${path_to_repos}/dotfiles/.config/nvim

mkdir -p ${path_to_work}
