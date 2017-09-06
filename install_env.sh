RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

cd $(dirname $0)
dir=`pwd -P`
echo "$RED>>> Scripts directory is $GREEN$dir$NC"

echo "$RED>>> Switching to home directory$NC"
cd

echo "$RED>>> Installing oh-my-zsh$NC"
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O install_oh_my_zsh.sh
sed -i "/env zsh/d" install_oh_my_zsh.sh
sh install_oh_my_zsh.sh
rm install_oh_my_zsh.sh

echo "$RED>>> Configuring .zshrc$NC"
mv .zshrc $dir/zshrc
ln -s $dir/zshrc .zshrc
sed -i "s/# DISABLE_AUTO_UPDATE/DISABLE_AUTO_UPDATE/" .zshrc
sed -i "s/# export PATH/export PATH/g" .zshrc
echo "export EDITOR=vim" | tee -a .zshrc > /dev/null

echo "$RED>>> Configuring oh-my-zsh theme$NC"
sed -i "s/ZSH_THEME\=\"robbyrussell\"/ZSH_THEME=\"zemen\"/" .zshrc
cp .oh-my-zsh/themes/robbyrussell.zsh-theme .oh-my-zsh/themes/zemen.zsh-theme
sed -i "s/%c/%~/" .oh-my-zsh/themes/zemen.zsh-theme

echo "$RED>>> Installing .vimrc and vundle$NC"
ln -s $dir/vimrc .vimrc
mkdir -p .vim/bundle 2> /dev/null
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

echo "$RED>>> Installing vim plugins$NC"
vim +PluginInstall +qall
mkdir .vim/UltiSnips 2> /dev/null
ln -s $dir/UltiSnips/cpp.snippets .vim/UltiSnips/cpp.snippets
ln -s $dir/ycm_extra_conf.py .vim/ycm_extra_conf.py
.vim/bundle/YouCompleteMe/install.py --clang-completer

echo "$RED>>> Installing .gitconfig$NC"
ln -s $dir/gitconfig .gitconfig

echo "$RED>>> Installing .tmux.conf$NC"
ln -s $dir/tmux.conf .tmux.conf

echo "$RED>>> Installing bin directory$NC"
mkdir bin 2> /dev/null
ln -s .vim/bundle/YCM-Generator/config_gen.py bin/ycm_config_gen
ln -s $dir/bin/compile bin/compile
chmod +x bin/compile
