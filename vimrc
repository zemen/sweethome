" Plugins "
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'SirVer/ultisnips'
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'luochen1990/rainbow'
Plugin 'majutsushi/tagbar'
Plugin 'oblitum/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
call vundle#end()
filetype plugin indent on

" Rainbow config "
let g:rainbow_active = 1

" YCM config "
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_goto_buffer_command = 'new-tab'

" UltiSnips config "
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Settings "
syntax on
set ai si nu sw=2 ts=2 sts=2 et spr
set enc=utf-8
set cino=N-s,g0,+2s,l-s,i2s
set cinw+=forn
set dir=$HOME/.vim/swapfiles//

" Mappings "
imap jk <esc>:w<cr>
map <c-j> 5j
map <c-k> 5k
map <c-p> :Files<cr>
map gd :YcmCompleter GoTo<cr>
map gD :YcmCompleter GetType<cr>
map gc <plug>NERDCommenterComment
map gu <plug>NERDCommenterUncomment
map <f9> :call Compile()<cr>
map <f5> :call Run()<cr>
map <f8> :TagbarToggle<cr>
map <f4> :!xclip -selection clipboard %<cr><cr>

" Abbreviatures "
ab pii pair<int, int>
ab vi vector<int>

" Compile and run "
let $CXXFLAGS="-O2 -DLOCAL -std=c++11 -Wall -Wextra -Wno-unused-result"
func! Compile()
  write
  if &filetype == "cpp" || &filetype == "c"
    let CXXFLAGS = $CXXFLAGS
    call system("grep '#include \"jngen.h\"' " . shellescape(expand("%")))
    if !v:shell_error 
      echom "Success"
      let $CXXFLAGS .= " -DJNGEN_DECLARE_ONLY "
      let $CXXFLAGS .= " src/libjngen.o "
    endif
    silent !echo
    silent !echo -e "\033[31;1m* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\033[0;m"
    silent make! %:r
    if len(getqflist()) > 1
      :!
    endif
    redraw!
    let $CXXFLAGS = CXXFLAGS
  elseif &filetype == "java"
    !javac %
  elseif &filetype == "tex"
    !pdflatex %
  else
    echom "Cannot compile file of type " . &filetype
  endif
  " redraw!
endf
func! Run()
  write
  if &filetype == "python"
    !python3 %
  elseif &filetype == "perl"
    !perl %
  elseif &filetype == "tex"
    !zathura %<.pdf 2>/dev/null &
  elseif &filetype == "sh" || &filetype == "bash"
    !bash %
  elseif &filetype == "java"
    !java %<
  elseif &filetype == "text"
    write
    wincmd w
    call Run()
    wincmd w
  else
    !./%<
  endif
endf
func! RunWithArgs()
  !xargs -L 1 ./%<
endf
