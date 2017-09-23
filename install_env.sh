#!/bin/bash

cd $(dirname $0)
dir=`pwd -P`
echo ">>> Scripts directory is $dir"

echo ">>> Switching to home directory"
cd

echo ">>> Installing oh-my-zsh"
export ZSH="`pwd -P`/.oh-my-zsh"
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O install_oh_my_zsh.sh
sed -i "/env zsh/d" install_oh_my_zsh.sh
sh install_oh_my_zsh.sh
rm install_oh_my_zsh.sh

echo ">>> Configuring .zshrc"
mv .zshrc $dir/zshrc
ln -s $dir/zshrc .zshrc
sed -i --follow-symlinks "s/# DISABLE_AUTO_UPDATE/DISABLE_AUTO_UPDATE/" .zshrc
sed -i --follow-symlinks "s/# export PATH/export PATH/g" .zshrc
echo "export EDITOR=vim" | tee -a .zshrc > /dev/null

echo ">>> Configuring oh-my-zsh completions"
mkdir .oh-my-zsh/completions 2> /dev/null
ln -s $dir/completions/_polygon-cli .oh-my-zsh/completions

echo ">>> Configuring oh-my-zsh theme"
sed -i --follow-symlinks "s/ZSH_THEME\=\"robbyrussell\"/ZSH_THEME=\"zemen\"/" .zshrc
cp .oh-my-zsh/themes/robbyrussell.zsh-theme .oh-my-zsh/themes/zemen.zsh-theme
sed -i "s/%c/%~/" .oh-my-zsh/themes/zemen.zsh-theme

echo ">>> Installing .vimrc and vundle"
ln -s $dir/vimrc .vimrc
mkdir -p .vim/bundle 2> /dev/null
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

echo ">>> Installing vim plugins"
vim +PluginInstall +qall
mkdir .vim/UltiSnips 2> /dev/null
ln -s $dir/UltiSnips/cpp.snippets .vim/UltiSnips/cpp.snippets
ln -s $dir/ycm_extra_conf.py .vim/ycm_extra_conf.py
.vim/bundle/YouCompleteMe/install.py --clang-completer

echo ">>> Installing .gitconfig"
ln -s $dir/gitconfig .gitconfig

echo ">>> Installing .tmux.conf"
ln -s $dir/tmux.conf .tmux.conf
tmux source .tmux.conf

echo ">>> Installing bin directory"
mkdir bin 2> /dev/null
ln -s $HOME/.vim/bundle/YCM-Generator/config_gen.py bin/ycm_config_gen
ln -s $dir/bin/compile bin/compile
chmod +x bin/compile

if which jupyter > /dev/null; then
  echo ">>> Installing jupyter-vim-binding"
  mkdir -p $(jupyter --data-dir)/nbextensions 2> /dev/null
  cd $(jupyter --data-dir)/nbextensions
  git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
  cd
  ln -s $dir/jupyter .jupyter
fi
