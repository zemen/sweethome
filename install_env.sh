echo "Switching to home directory"
cd

echo "Installing oh-my-zsh"
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O install_oh_my_zsh.sh
sed -i "/env zsh/d" install_oh_my_zsh.sh
sh install_oh_my_zsh.sh
rm install_oh_my_zsh.sh

echo "Configuring .zshrc"
sed -i "s/# DISABLE_AUTO_UPDATE/DISABLE_AUTO_UPDATE/" .zshrc
echo "export EDITOR=vim" | tee -a .zshrc > /dev/null
echo "export PATH=$PATH:~/bin" | tee -a .zshrc > /dev/null

echo "Configuring oh-my-zsh theme"
sed -i "s/ZSH_THEME\=\"robbyrussell\"/ZSH_THEME=\"zemen\"/" .zshrc
cp .oh-my-zsh/themes/robbyrussell.zsh-theme .oh-my-zsh/themes/zemen.zsh-theme
sed -i "s/%c/%~/" ~/.oh-my-zsh/themes/zemen.zsh-theme

echo "Installing .vimrc and vundle"
wget https://raw.githubusercontent.com/zemen/sweethome/master/.vimrc -O ~/.vimrc
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing vim plugins"
vim +PluginInstall +qall
~/.vim/bundle/YouCompleteMe/install.py --clang-completer
