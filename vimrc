"{{{ Set parameters
"colorscheme ir_black
"colorscheme default
"colorscheme wombat
"colorscheme vibrantink
colorscheme vividchalk
" none of that!

if has("gui_running")
    colorscheme wombat
endif

set guioptions=
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
set pastetoggle=<C-i>
set shm=aI
set noignorecase
set clipboard=unnamed
set showcmd
set splitbelow
"set cindent
set et
set mouse -=a
"}}}
"{{{ autocmd/filetypes
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
"}}}
" {{{ Variables
" Standard Vim Vars
let mapleader = ","
" Tell GPG to use ascii files for new files
let g:GPGPreferArmor = 1
let g:GPGUseAgent = 0
" Fold XML Files
let g:xml_syntax_folding=1
" VimWiki
let g:vimwiki_list = [{"path":"~/.wiki/work","path_html":"~/.wiki/work/html" }]
" For project plugin
let g:proj_flags="cgst"
"}}}
"{{{ Maps
" TwitVim
let twitvim_browser_cmd="open"
nmap <Leader>tf :FriendsTwitter<CR>
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
nmap <Leader>nt :NERDTreeToggle<CR>
" Git Stuff
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gl :Glog<CR>
nmap <Leader>gc :Gcommit<CR>
map <Leader>gh :Gbrowse<CR>
" Clear entire buffer
nmap <Leader>db ggVGd

"" Wiki Stuff
"Make the current word a wikiword
nmap <Leader>mw bi[[<Esc>wea]]<Esc>
" Open current wikiword in new split
nmap <Leader>wws <Plug>VimwikiSplitWord
nmap <Leader>wwt <Plug>VimwikiSplitWord<C-w>T
nmap <Leader>wtt <Plug>VimwikiToggleListItem

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

"allows me to add fold to a function/class (in php only?)
nmap <C-c>f /{<Enter>%o<Esc>k%?func<Enter>O<Esc>Vj/{<Enter>%jzfzojf(bveykhhpzco<Esc>Vk=j
nmap <C-c>c O<Esc>Vj/{<Enter>%jzfzojwveykhhpa class<Esc>zco<Esc>

"don't want visual mode :)
nmap Q q

"Change tabs
imap <C-l> <Esc>gt
imap <C-h> <Esc>gT
nmap <C-l> gt
nmap <C-h> gT

vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>
"}}}
"{{{ Misc Functions
" * and # search for next/previous of selected text when used in visual mode
function! s:VSetSearch()
  let old = @"
  norm! gvy
  let @/ = '\V' . substitute(escape(@", '\'), '\n', '\\n', 'g')
  let @" = old
endfunction

"}}}
"{{{ Run Functions
nmap <Leader>pr :perlx<CR>

" vim:fdm=marker:
