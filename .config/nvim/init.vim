" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" colorschemes
Plug 'tomasr/molokai'
Plug 'whatyouhide/vim-gotham'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" productivity
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-clang-format'

" Initialize plugin system
call plug#end()

colorscheme molokai
let g:rehash256 = 1

" vim-airline customization
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='deus'

filetype plugin on
syntax on
let mapleader = ","
imap jj <Esc>
set mouse=a
set scrolloff=8
set nu
set rnu
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set noexpandtab
set hlsearch
set incsearch
set ignorecase
set autoread
set termguicolors
set nohlsearch

" {{{ fzf customization
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'
let $FZF_DEFAULT_OPTS='--reverse'

function! s:my_fzf_handler(lines) abort
  if empty(a:lines)
    return
  endif
  let cmd = get({ 'ctrl-t': 'tabedit',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vsplit' }, remove(a:lines, 0), 'e')
  for item in a:lines
    execute cmd escape(item, ' %#\')
  endfor
endfunction

nnoremap <silent> <C-P> :call fzf#run({
  \ 'source': 'git ls-files',
  \ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v',
  \ 'window':  {'width': 0.9, 'height': 0.6},
  \ 'sink*':   function('<sid>my_fzf_handler')})<cr>

nnoremap <silent> <C-T> :call fzf#run({
  \ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v',
  \ 'window':  {'width': 0.9, 'height': 0.6},
  \ 'sink*':   function('<sid>my_fzf_handler')})<cr>

nmap <silent> <leader>ff :Buffers<cr>
nmap <silent> <leader>fg :Rg<cr>

" remember last position
" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
        \ execute("normal `\"") |
    \ endif

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.nviminfo

" tabbed windows (command mode)
nmap <S-T> :tabnew<enter>
nmap <S-H> :tabprev<enter>
nmap <S-L> :tabnext<enter>
nmap <S-K> :tabclose<enter>

" buffer management
nmap <C-H> :bp<enter>
nmap <C-L> :bn<enter>
nmap <C-K> :bd<enter>

" moving around buffers via Alt modifier
nmap <A-h> :wincmd h<enter>
nmap <A-j> :wincmd j<enter>
nmap <A-k> :wincmd k<enter>
nmap <A-l> :wincmd l<enter>

" CoC related
set cmdheight=2
set hidden
set updatetime=300
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-highlight',
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

nmap <Leader>ch :call CocActionAsync('doHover')<cr>
nmap <silent> <Leader>cm :call CocActionAsync<cr>
nmap <silent> <leader>cs <Plug>(coc-fix-current)
nmap <silent> <Leader>cd <Plug>(coc-definition)
nmap <silent> <Leader>cy <Plug>(coc-type-definition)
nmap <silent> <Leader>ci <Plug>(coc-implementation)
nmap <silent> <Leader>cr <Plug>(coc-references)
nmap <silent> <Leader>cn <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>cp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cm <Plug>(coc-rename)
nmap <silent> <Leader>gp :GFiles<CR>

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" clang-format support"
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

" Debugging support
packadd termdebug

" open up debug windows in vertical split
let g:termdebug_wide = 10

nmap <C-F5>  :Stop <CR>
nmap <F5>    :Continue <CR>
nmap <F6>    :Run <CR>
nmap <F9>    :Break <CR>
nmap <F8>    :Clear <CR>
nmap <F10>   :Over <CR>
nmap <F11>   :Step <CR>
nmap <F12>   :Finish <CR>
nmap <S-F10> :Finish <CR>

nmap <Leader>dr :Run <Cr>
nmap <Leader>ds :Stop <Cr>
nmap <Leader>dc :Continue <Cr>

nmap <Leader>db :Break <Cr>
nmap <Leader>dd :Clear <Cr>

nmap <Leader>dn :Over <Cr>
nmap <Leader>di :Step <Cr>
nmap <Leader>df :Finish<Cr>

" XXX example debug command:
"      :Termdebug ./path/to/binary [parameters ...]
" Quickfix window navigation (qn = next, qp = prev)
nmap <silent> <Leader>qn :cn<CR>
nmap <silent> <Leader>qp :cp<CR>

