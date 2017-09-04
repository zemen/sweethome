RED='\033[0;31m'
NC='\033[0m'

echo "${RED}>>> Switching to home directory${NC}"
cd

echo "${RED}>>> Installing oh-my-zsh${NC}"
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O install_oh_my_zsh.sh
sed -i "/env zsh/d" install_oh_my_zsh.sh
sh install_oh_my_zsh.sh
rm install_oh_my_zsh.sh

echo "${RED}>>> Configuring .zshrc${NC}"
sed -i "s/# DISABLE_AUTO_UPDATE/DISABLE_AUTO_UPDATE/" .zshrc
sed -i "s/# export PATH/export PATH/g" .zshrc
echo "export EDITOR=vim" | tee -a .zshrc > /dev/null
echo "Configuring oh-my-zsh theme"
sed -i "s/ZSH_THEME\=\"robbyrussell\"/ZSH_THEME=\"zemen\"/" .zshrc
cp .oh-my-zsh/themes/robbyrussell.zsh-theme .oh-my-zsh/themes/zemen.zsh-theme
sed -i "s/%c/%~/" ~/.oh-my-zsh/themes/zemen.zsh-theme

echo "${RED}>>> Installing .vimrc and vundle${NC}"
wget https://raw.githubusercontent.com/zemen/sweethome/master/vimrc -O ~/.vimrc
mkdir -p ~/.vim/bundle 2> /dev/null
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "${RED}>>> Installing vim plugins${NC}"
vim +PluginInstall +qall
wget https://raw.githubusercontent.com/zemen/sweethome/master/ycm_extra_conf.py -O ~/.vim/ycm_extra_conf.py
~/.vim/bundle/YouCompleteMe/install.py --clang-completer

echo "${RED}>>> Installing .gitconfig${NC}"
wget https://raw.githubusercontent.com/zemen/sweethome/master/gitconfig -O ~/.gitconfig

echo "${RED}>>> Installing bin directory${NC}"
mkdir ~/bin 2> /dev/null
ln -s ~/.vim/bundle/YCM-Generator/config_gen.py ~/bin/ycm_config_gen
wget https://raw.githubusercontent.com/zemen/sweethome/master/bin/compile -O ~/bin/compile
chmod +x ~/bin/compile
