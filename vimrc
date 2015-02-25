syntax on

set background=dark
colorscheme vibrantink
if has('gui_running')
    colorscheme vividchalk
    set lines=57
    set columns=173
endif

" Nasty alias stuff that naveed says i'll regret
set shellcmdflag=-ic

set incsearch

set ic
"set relativenumber
"set lcs=tab:▹\ ,eol:¬,trail:·,extends:«,precedes:»
"set list!
set hidden " for lustyjuggler/ explorer
set guioptions=
set laststatus=2
set guifont=Menlo\ for\ Powerline
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
"set foldmethod=indent
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
try
    set cc=80 guibg=#592929
catch
endtry

"Include $ in varibale names
set iskeyword=@,48-57,_,192-255,#,$

" Highlight trailing whitespace in vim on non empty lines, but not while typing in insert mode!
highlight ExtraWhitespace ctermbg=red guibg=Brown
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\S\zs\s\+$/
au InsertEnter * match ExtraWhitespace /\S\zs\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\S\zs\s\+$/

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="
"Au to source vimrc
autocmd! bufwritepost .vimrc source %
autocmd FileType xml set foldmethod=syntax
autocmd FileType xml set foldlevel=100
autocmd FileType mail execute "normal }O\<Esc>o"
au BufRead,BufNewFile *.tal setfiletype html
au BufRead,BufNewFile *.tt setfiletype html
au BufRead,BufNewFile *.t setfiletype perl
filetype plugin on
filetype indent on
filetype on
"VALA STUFF
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala
au BufRead,BufNewFile Rexfile setfiletype perl

autocmd BufRead *.mako set ft=html
au BufRead,BufNewFile *.mako            setfiletype html
call pathogen#runtime_append_all_bundles() 

" Make :W work like :w
":cmap W w
":cmap w:w w


let g:github_user = 'throughnothing'
"let g:textobj_between_no_default_key_mappings = 1
let g:neocomplcache_enable_at_startup = 1
" Ctags
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
" Powerline
let g:Powerline_symbols = 'fancy'

" CTRLP
" Set Ctrl-P to show match at top of list instead of at bottom, which is so
" stupid that it's not default
let g:ctrlp_match_window_reversed = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.DS_Store,*.tgz,*.gz

" Tell Ctrl-P to keep the current VIM working directory when starting a
" search, another really stupid non default
let g:ctrlp_working_path_mode = 0

" Ctrl-P ignore target dirs so VIM doesn't have to! Yay!
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|local|locallib)$',
  \ 'file': '\v\.(exe|so|dll|tgz|gz)$',
  \ }

" Open a new file in a tab by default
let g:ctrlp_open_multi = '10t'

"Vim-script-runner
let g:script_runner_map = "<Leader>sx"
"let g:script_runner_perl = "perl -Ilib -Mojo -MData::Dumper -MData::Dump -Mv5.10 -MClass::Autouse=:superloader -Mwarnings -MFile::Slurp  -Mutf8::all"
let g:script_runner_perl = "perl -Ilib -Mojo -MData::Dumper -MData::Dump -Mv5.10 -Mwarnings -MFile::Slurp  -Mutf8::all"
let g:script_runner_javascript = "node"

let mapleader = ","
" Tell GPG to use ascii files for new files
let g:GPGPreferArmor = 1
let g:GPGUseAgent = 0
"
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }
inoremap jj <esc>
" Heresy
inoremap <C-i> <esc>I
inoremap <C-a> <esc>

" lets you do w!! to sudo write the file
nnoremap <Leader>w! :w !sudo tee % >/dev/null<cr>

" TwitVim
let twitvim_browser_cmd="open"
" Delete all trailing spaces from lines
nmap <Leader><Leader>ds :%s/\s\+$//g<CR>
nmap <Leader>yr :YRShow<CR>
nmap <Leader>tf :FriendsTwitter<CR>
nmap <Leader>tp :PosttoTwitter<CR>

" Better paste defaults
nmap p ]p
nmap P ]P

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
nmap <Leader>gds :Gdiff --staged<CR>
nnoremap <Leader>df :tabe diff<CR>:set ft=diff fdm=manual noswf bt=nowrite bh=delete<cr>:r !git diff<CR>ggdd
nnoremap <Leader>dfs :tabe diff<CR>:set ft=diff fdm=manual noswf bt=nowrite bh=delete<cr>:r !git diff --staged<CR>ggdd
nnoremap <Leader>gl :tabe gitlog<CR>:set ft=git fdm=manual noswf bt=nowrite bh=delete<cr>:r !git log<CR>ggdd
nnoremap <Leader>glp :tabe gitlog<CR>:set ft=git fdm=manual noswf bt=nowrite bh=delete<cr>:r !git log -p<CR>ggdd
nmap <Leader>glf :Extradite!<CR>
nmap <Leader>gc :Gcommit<CR>
map <Leader>gh :Gbrowse<CR>
" Gist Stuff
let g:gist_show_privates = 1
let g:gist_get_multiplefile = 1
" Clear entire buffer
nmap <Leader>db ggVGd

map K k
nmap <C-w>t <C-w>]<C-w>T

" Append date to end of current line
nmap <Leader>ad A - <Esc>:r!date<CR>kJ

"for showing tabs,etc
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
