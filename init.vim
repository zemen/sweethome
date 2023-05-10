" Plugins "
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'github/copilot.vim'
call plug#end()

" CoC config "
inoremap <silent><expr> <TAB>
      \ coc#jumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()
function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
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

" Settings "
set nu sw=2 ts=2 et tm=200 ut=300 scl=yes nobk nowb
set cino=N-s,g+1,h+1,+2s,l-s,i2s

" vim-commentary settings
autocmd FileType cpp setlocal commentstring=//\ %s

" C++ settings
let $CXXFLAGS="-O2 -DLOCAL -std=c++20 -Wall -Wextra"
ab pii pair<int, int>
ab vi vector<int>

" Mappings "
imap jk <esc>:w<cr>
map <c-j> 5j
map <c-k> 5k
map <c-p> :Files<cr>
nmap gc <Plug>CommentaryLine
xmap gc <Plug>Commentary
map gf :call CocActionAsync('format')<cr>
map <f9> :make! %:r<cr>
map <f5> :call Run()<cr>
map <f4> :!xclip -selection clipboard %<cr><cr>

func! Run()
  write
  if &filetype == "python"
    !python3 %
  elseif &filetype == "sh" || &filetype == "bash"
    !bash %
  else
    !./%<
  endif
endf
