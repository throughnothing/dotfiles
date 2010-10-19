"{{{ Set parameters
"colorscheme ir_black
"colorscheme default
"colorscheme wombat
colorscheme vibrantink
syntax on
set modeline
set hls
set ls=2
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set bs=2
set ruler
"set foldmethod=marker
set foldmethod=indent
set foldlevel=0
set foldnestmax=20
set tags=tags;
set pastetoggle=<C-i>
set shm=aI
set ignorecase
"set clipboard=unnamed
set showcmd
set splitbelow
"set cindent
set et
"}}}
"{{{ autocmd/filetypes
"Auto source vimrc
autocmd! bufwritepost .vimrc source %
autocmd FileType xml set foldmethod=syntax
autocmd FileType xml set foldlevel=100
au BufRead,BufNewFile *.tal		setfiletype html
filetype plugin on
filetype indent on
filetype on
"VALA STUFF
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala
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
nmap [[ [{
nmap ]] ]}
nmap <Leader>P :Project<CR>
" Clear entire buffer
nmap <Leader>cb ggVGd
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
nmap ,v :tabe ~/.vimrc<CR>
nmap <C-j> i<CR><Esc>
"nmap te :tabe 

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

map <Leader>f :call BrowserOpen()<CR>
function! BrowserOpen ()
  let l:line = getline (".")
  let l:url = ""
perl << EOF
  my $line = VIM::Eval('l:line');
  $line =~ m/((https?:\/\/|www\.)[^\s",;\t'>]*)\b/;
  VIM::DoCommand("let l:url = '$1'");
EOF
  echo "Opening " . l:url
  silent exec "!elinks ".l:url
  redraw!
endfunction
nmap <Leader>cu :call CopyURL()<CR>
function! CopyURL ()
  let l:line = getline (".")
  let @* = matchstr (l:line, "http://[^ \",;\t'>]*")
endfunction
"}}}
"{{{ Run Functions
cabbrev antt call AntTest()
cabbrev anti call AntIntTest()
cabbrev antm call AntMake()
cabbrev phpl call PhpSyntaxCheck()
cabbrev phpr call PhpRun()
cabbrev pyr call PythonRun()
cabbrev br call BashRun()
cabbrev perlx call PerlRun()
cabbrev perlt call PerlTest()

fu! AntMake()
	let l:mp = &mp
	let l:efm = &efm

	set efm&vim
	set mp=ant\ unittest\ \\\|&\ perl\ anterror.pl
	silent make!
	redraw!
	exe "set mp= " . l:mp
	exe "set efm= " . l:efm
	cope
endf

fu! AntTest()
    on
    call Run("ant test", 20)
endf

fu! AntIntTest()
    on
    call Run("ant inttest", 20)
endf

fu! PhpSyntaxCheck()
    on
    let l:file = @%
    call Run("php -l " . l:file, 3)
endf

fu! PhpRun()
    on
    let l:file = @%
    call Run("php " . l:file, 10)
endf

fu! PythonRun()
    on
    let l:file = @%
    call Run("python " . l:file, 10)
endf

fu! BashRun()
    on
    let l:file = @%
    call Run("bash " . l:file, 10)
endf

fu! PerlRun()
    on
    let l:file = @%
    call Run("perl " . l:file, 10)
endf

fu! Run(command, winSize)
    on
    pedit RunCommand

    exe "normal \<C-W>Z"
    exe "normal \<C-W>P"
    exe "normal \<C-W>J"

    setlocal noswapfile
    setlocal buftype=nowrite
    setlocal bufhidden=delete " d
	map <buffer> q :quit<CR>

    exec "resize " . a:winSize
    exe "%!" . a:command
    0 read !date
    echo a:winSize
    append
----------------------------
.
    exe "normal G"
    exe "normal \<C-W>W"
endf
"}}}

" vim:fdm=marker:
