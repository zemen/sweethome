" Plugins "
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'flazz/vim-colorschemes'
"Plugin 'jeaye/color_coded'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'majutsushi/tagbar'
Plugin 'rdnetto/YCM-Generator'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'ycm-core/YouCompleteMe'
call vundle#end()
filetype plugin indent on

" YCM config "
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_goto_buffer_command = 'new-tab'
let g:SuperTabDefaultCompletionType = "<c-n>"
au FileType python setlocal ts=2 sts=2 sw=2 et

" UltiSnips config "
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Settings "
syntax on
set ai si nu sw=2 ts=2 sts=2 et spr tm=200 hls t_Co=256
set enc=utf-8
set cino=N-s,g+1,h+1,+2s,l-s,i2s
set cinw+=forn
set dir=$HOME/.vim/swapfiles//
set keymap=russian-jcukenwin
set iminsert=0

let $CXXFLAGS="-O2 -DLOCAL -std=c++17 -Wall -Wextra"

" Mappings "
imap jk <esc>:w<cr>
map <c-j> 5j
map <c-k> 5k
map <c-p> :Files<cr>
map gd :YcmCompleter GoTo<cr>
map gD :YcmCompleter GetType<cr>
map gc <plug>NERDCommenterComment
map gu <plug>NERDCommenterUncomment
map gf :ClangFormat<cr>
map <f9> :make! %:r<cr>
map <f5> :call Run()<cr>
map <f8> :TagbarToggle<cr>
map <f4> :!xclip -selection clipboard %<cr><cr>

" Abbreviatures "
ab pii pair<int, int>
ab vi vector<int>

func! Run()
  write
  if &filetype == "python"
    !python3 %
  elseif &filetype == "tex"
    !xdg-open %<.pdf 2>/dev/null &
  elseif &filetype == "sh" || &filetype == "bash"
    !bash %
  elseif &filetype == "java"
    !java %<
  else
    !./%<
  endif
endf
