#!/bin/bash

declare -a REQUIREMENTS=("curl" "sed" "zsh" "nvim" "node" "tmux" "git" "npm")
for COMMAND in "${REQUIREMENTS[@]}"
do
  if ! command -v $COMMAND &> /dev/null
  then
    echo "$COMMAND is required"
    exit
  fi
done

cd $(dirname $0)
dir=`pwd -P`
echo ">>> Scripts directory is $dir"

echo ">>> Switching to home directory"
cd

echo ">>> Installing oh-my-zsh"
export ZSH="`pwd -P`/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo ">>> Configuring .zshrc"
mv .zshrc $dir/zshrc
ln -s $dir/zshrc .zshrc
sed -i --follow-symlinks "s/# export PATH/export PATH/g" .zshrc
echo "export EDITOR=nvim" | tee -a .zshrc > /dev/null

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

echo ">>> Installing init.vim and vim-plug"
mkdir -p ~/.config/nvim 2> /dev/null
ln -s $dir/init.vim ~/.config/nvim/
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo ">>> Installing vim plugins"
nvim +PlugInstall +qall
ln -s $dir/coc-settings.json .config/nvim/
ln -s $dir/UltiSnips .config/nvim/

echo ">>> Installing CoC plugins"
nvim +CocInstall coc-sh coc-clangd coc-cmake coc-go coc-java coc-json coc-markdownlint coc-pyright coc-solidity coc-snippets +qall

echo ">>> Installing .gitconfig"
ln -s $dir/gitconfig .gitconfig

echo ">>> Installing oh-my-tmux"
git clone https://github.com/gpakosz/.tmux.git ~/.oh-my-tmux
ln -s -f ~/.oh-my-tmux/.tmux.conf ~/.tmux.conf
ln -s $dir/tmux.conf.local ~/.tmux.conf.local

echo ">>> Installing bin directory"
mkdir bin 2> /dev/null
ln -s $dir/bin/compile bin/compile
chmod +x bin/compile
ln -s $HOME/.oh-my-zsh/custom/plugins/fzf/bin/fzf bin
ln -s $HOME/.oh-my-zsh/custom/plugins/fzf/bin/fzf-tmux bin
