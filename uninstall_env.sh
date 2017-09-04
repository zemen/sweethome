RED='\033[0;31m'
NC='\033[0m'

echo "${RED}>>> Switching to home directory${NC}"
cd

echo "${RED}>>> Removing .zshrc${NC}"
rm .zshrc

echo "${RED}>>> Uninstalling oh-my-zsh${NC}"
rm -rf .oh-my-zsh

echo "${RED}>>> Removing .vimrc${NC}"
rm .vimrc

#echo "${RED}>>> Removing vim plugins${NC}"
#rm -rf .vim

echo "${RED}>>> Removing bin directory${NC}"
rm -rf bin
