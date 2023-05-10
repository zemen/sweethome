echo ">>> Switching to home directory"
cd

echo ">>> Removing .zshrc"
rm .zshrc

echo ">>> Uninstalling oh-my-zsh"
rm -rf .oh-my-zsh

echo ">>> Removing .nvim"
rm -rf .config/nvim

echo ">>> Removing .gitconfig"
rm .gitconfig

echo ">>> Removing bin directory"
rm -rf bin

echo ">>> Uninstalling oh-my-tmux"
rm -rf .oh-my-tmux
rm .tmux.conf
rm .tmux.conf.local
