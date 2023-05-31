" Plugins "
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'github/copilot.vim'
call plug#end()

" Completion "
let g:copilot_no_tab_map = v:true
inoremap <silent><expr> <TAB>
      \ coc#jumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()
" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space>
      \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") : coc#refresh()

" CoC config "
function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" Rename
nmap <leader>rn <Plug>(coc-rename)
" Quickfix
nmap <leader>qf  <Plug>(coc-fix-current)

" Settings "
set nu sw=2 ts=2 et tm=200 ut=300 scl=yes nobk nowb spr
set cino=N-s,g0,+2s,l-s,i2s

" vim-commentary settings
autocmd FileType cpp setlocal commentstring=//\ %s

" C++ settings
let $CXXFLAGS="-O2 -DLOCAL -std=c++20 -Wall -Wextra"
ab pii pair<int, int>
ab vi vector<int>

" Mappings "
imap jk <esc>
map <c-j> 5j
map <c-k> 5k
map <c-p> :Files<cr>
nmap gc <Plug>CommentaryLine
xmap gc <Plug>Commentary
map gf :call CocActionAsync('format')<cr>
map <f9> :make! %:r<cr>
map <f5> :call Run()<cr>
map <f4> :!xclip -selection clipboard %<cr><cr>

" Terminal "
tnoremap <Esc> <C-\><C-n>
au TermOpen * setlocal nonumber signcolumn=no | startinsert
au TermClose * setlocal number signcolumn=yes | call feedkeys("\<C-\>\<C-n>")

func! Run()
  write
  if &filetype == "python"
    terminal python3 %
  elseif &filetype == "sh" || &filetype == "bash"
    terminal %
  else
    terminal ./%< < %<.in
  endif
endf
