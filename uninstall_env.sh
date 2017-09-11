echo ">>> Switching to home directory"
cd

echo ">>> Removing .zshrc"
rm .zshrc

echo ">>> Uninstalling oh-my-zsh"
rm -rf .oh-my-zsh

echo ">>> Removing .vimrc"
rm .vimrc

#echo ">>> Removing vim plugins"
#rm -rf .vim

echo ">>> Removing .gitconfig"
rm .gitconfig

echo ">>> Removing bin directory"
rm -rf bin

echo ">>> Removing tmux.conf"
rm .tmux.conf
