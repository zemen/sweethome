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
ln -s $dir/zemen.zsh-theme .oh-my-zsh/themes

echo ">>> Installing fzf"
mkdir -p .oh-my-zsh/custom/plugins 2> /dev/null
git clone https://github.com/junegunn/fzf.git .oh-my-zsh/custom/plugins/fzf
.oh-my-zsh/custom/plugins/fzf/install --bin
git clone https://github.com/Treri/fzf-zsh.git .oh-my-zsh/custom/plugins/fzf-zsh
sed -i --follow-symlinks "s/plugins=(git)/plugins=(git fzf-zsh)/g" .zshrc

echo ">>> Installing .vimrc and vundle"
ln -s $dir/vimrc .vimrc
mkdir -p .vim/bundle 2> /dev/null
mkdir .vim/swapfiles
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

echo ">>> Installing vim plugins"
vim +PluginInstall +qall
mkdir .vim/UltiSnips 2> /dev/null
ln -s $dir/UltiSnips/cpp.snippets .vim/UltiSnips/cpp.snippets
ln -s $dir/ycm_extra_conf.py .vim/ycm_extra_conf.py

echo ">>> Installing YouCompleteMe"
.vim/bundle/YouCompleteMe/install.py --clangd-completer

#echo ">>> Installing color_coded"
#cd ~/.vim/bundle/color_coded
#mkdir build && cd build
#cmake ..
#make -j5 && make install
#make clean && make clean_clang
#cd

echo ">>> Installing .gitconfig"
ln -s $dir/gitconfig .gitconfig

echo ">>> Installing oh-my-tmux"
git clone https://github.com/gpakosz/.tmux.git ~/.oh-my-tmux
ln -s -f ~/.oh-my-tmux/.tmux.conf ~/.tmux.conf
ln -s $dir/tmux.conf.local ~/.tmux.conf.local

echo ">>> Installing bin directory"
mkdir bin 2> /dev/null
ln -s $HOME/.vim/bundle/YCM-Generator/config_gen.py bin/ycm_config_gen
ln -s $dir/bin/compile bin/compile
chmod +x bin/compile
ln -s $dir/bin/commit_submodule bin/commit_submodule
chmod +x bin/commit_submodule
ln -s $HOME/.oh-my-zsh/custom/plugins/fzf/bin/fzf bin
ln -s $HOME/.oh-my-zsh/custom/plugins/fzf/bin/fzf-tmux bin
