colorscheme vibrantink
if has("gui_running")
    colorscheme wombat
endif

set guioptions=
set laststatus=2
set guifont=Menlo\ for\ Powerline
syntax on
set modeline
set hls
set ls=2
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set bs=2
set ruler
"set foldmethod=marker
set foldmethod=indent
set foldlevel=0
set foldnestmax=20
set tags=tags;
set pastetoggle=<C-p>
set shm=aI
set noignorecase
set clipboard=unnamed
set showcmd
set splitbelow
set et
set mouse -=a
set textwidth=80
set cc=+1

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="
"Au to source vimrc
autocmd! bufwritepost .vimrc source %
autocmd FileType xml set foldmethod=syntax
autocmd FileType xml set foldlevel=100
autocmd FileType mail execute "normal }O\<Esc>o"
au BufRead,BufNewFile *.tal setfiletype html
au BufRead,BufNewFile *.tt setfiletype html
filetype plugin on
filetype indent on
filetype on
"VALA STUFF
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

autocmd BufRead *.mako set ft=html
au BufRead,BufNewFile *.mako            setfiletype html
call pathogen#runtime_append_all_bundles() 

" Powerline
let g:Powerline_symbols = 'fancy'

" CTRLP
" Set Ctrl-P to show match at top of list instead of at bottom, which is so
" stupid that it's not default
let g:ctrlp_match_window_reversed = 0

" Tell Ctrl-P to keep the current VIM working directory when starting a
" search, another really stupid non default
let g:ctrlp_working_path_mode = 0

" Ctrl-P ignore target dirs so VIM doesn't have to! Yay!
let g:ctrlp_custom_ignore = {'dir':  '\/target\/\'}

" Open a new file in a tab by default
let g:ctrlp_open_multi = '10t'

"Vim-script-runner
let g:script_runner_map = "<Leader>sx"
let g:script_runner_perl = "perl -MData::Dump"

let mapleader = ","
" Tell GPG to use ascii files for new files
let g:GPGPreferArmor = 1
let g:GPGUseAgent = 0
"
inoremap jj <esc>
" Heresy
inoremap <C-i> <esc>I
inoremap <C-a> <esc>

" TwitVim
let twitvim_browser_cmd="open"
nmap <Leader>tf :FriendsTwitter<CR>

" Command-T file finder
nnoremap <silent> <Leader>T :CommandT<cr>
let g:CommandTAcceptSelectionMap = '<CR>'
let g:CommandTAcceptSelectionTabMap = '<C-t>'

"Tagbar
nmap <Leader>tb :TagbarToggle<CR>

" write all files and save session
nnoremap <Leader>gu :GundoToggle<CR>
nmap <Leader>sb :set scb!<CR>
nmap <Leader>SS :wa<CR><Leader>ss
nmap <Leader>lcd :cd %:p:h<CR><Leader>sl<CR>
nmap [[ [{
nmap ]] ]}
nmap <Leader>P :Project<CR>
nmap <Leader>ct :CommandT<CR>

let g:nerdtree_tabs_open_on_gui_startup=0
nmap <Leader>nt :NERDTreeTabsToggle<CR>
" Git Stuff
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gl :Glog<CR>
nmap <Leader>gc :Gcommit<CR>
map <Leader>gh :Gbrowse<CR>
" Clear entire buffer
nmap <Leader>db ggVGd

map K k
nmap <C-w>t <C-w>]<C-w>T 

" Append date to end of current line
nmap <Leader>ad A - <Esc>:r!date<CR>kJ

"for showing tabs,etc
set lcs=tab:▹\ ,eol:¬,trail:·,extends:«,precedes:»
map <Leader>lt :setlocal list!<CR>

"C-c to escape
inoremap <C-c> <Esc><Esc>

"Edit vimrc file
nmap <Leader>v :tabe ~/.vimrc<CR>
nmap <Leader>s :so ~/.vimrc<CR>
nmap <C-j> i<CR><Esc>

"Grep recursively in all files for the current word
nmap <Leader>g yiw :exe 'grep! -ir -I ' @0 '*'<CR>

"XML Formatting function
nmap <C-x>f :silent 1,$!xmllint --format --recover - 2>/dev/null<CR>

"don't want visual mode :)
nmap Q q

"nmap <Leader>sr :sx<CR>

"Change tabs
imap <C-l> <Esc>gt
imap <C-h> <Esc>gT
nmap <C-l> gt
nmap <C-h> gT

" * and # search for next/previous of selected text when used in visual mode
vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>
function! s:VSetSearch()
  let old = @"
  norm! gvy
  let @/ = '\V' . substitute(escape(@", '\'), '\n', '\\n', 'g')
  let @" = old
endfunction

augroup VimperatorYPentadactyl
    au! BufRead vimperator-*,pentadactyl-* nnoremap <buffer> ZZ :silent write \| :bd \| :macaction hide:<CR>
    au BufRead vimperator-*,pentadactyl-* imap <buffer> ZZ <Esc>ZZ
augroup END
