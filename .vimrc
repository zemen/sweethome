let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'oblitum/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
call vundle#end()
filetype plugin indent on

set cinw+=forn
imap jk <esc>:w<cr>
imap {<cr> {<cr>}<esc>O
map <c-j> 5j
map <c-k> 5k
map H ^
map L $
set ai si nu sw=2 ts=2 sts=2 et spr
set cino=N-s,g0,+2s,l-s,i2s
map gd :YcmCompleter GoTo<cr>
map gc <leader>c<Space>
map gu gc

let $CXXFLAGS="-O2 -DLOCAL -std=c++1y -Wall -Wextra -Wno-unused-result"
map <f9> :w<cr>:make! %:r<cr>
map <f5> :w<cr>:!./%<<cr>
map <f4> :vs %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>
map <f8> :w<cr>:!python3 %<cr>
