" Vimwiki syntax file
" GoogleWiki syntax
" Author: Maxim Kim <habamax@gmail.com>
" Home: http://code.google.com/p/vimwiki/

" text: *strong*
" let g:vimwiki_rxBold = '\*[^*]\+\*'
let g:vimwiki_rxBold = '\(^\|\s\+\|[[:punct:]]\)\zs\*[^*`]\+\*\ze\([[:punct:]]\|\s\+\|$\)'

" text: _emphasis_
" let g:vimwiki_rxItalic = '_[^_]\+_'
let g:vimwiki_rxItalic = '\(^\|\s\+\|[[:punct:]]\)\zs_[^_`]\+_\ze\([[:punct:]]\|\s\+\|$\)'

" text: *_strong italic_* or _*italic strong*_
let g:vimwiki_rxBoldItalic = '\(^\|\s\+\|[[:punct:]]\)\zs\(\*_[^*_`]\+_\*\)\|\(_\*[^*_`]\+\*_\)\ze\([[:punct:]]\|\s\+\|$\)'

" text: `code`
let g:vimwiki_rxCode = '`[^`]\+`'

" text: ~~deleted text~~
let g:vimwiki_rxDelText = '\~\~[^~`]\+\~\~'

" text: ^superscript^
let g:vimwiki_rxSuperScript = '\^[^^`]\+\^'

" text: ,,subscript,,
let g:vimwiki_rxSubScript = ',,[^,`]\+,,'

" Header levels, 1-6
let g:vimwiki_rxH1 = '^\s*=\{1}.*=\{1}\s*$'
let g:vimwiki_rxH2 = '^\s*=\{2}.*=\{2}\s*$'
let g:vimwiki_rxH3 = '^\s*=\{3}.*=\{3}\s*$'
let g:vimwiki_rxH4 = '^\s*=\{4}.*=\{4}\s*$'
let g:vimwiki_rxH5 = '^\s*=\{5}.*=\{5}\s*$'
let g:vimwiki_rxH6 = '^\s*=\{6}.*=\{6}\s*$'

" <hr>, horizontal rule
let g:vimwiki_rxHR = '^----.*$'

" Tables. Each line starts and ends with '||'; each cell is separated by '||'
let g:vimwiki_rxTable = '||'

" Bulleted list items start with whitespace(s), then '*'
" syntax match wikiList           /^\s\+\(\*\|[1-9]\+0*\.\).*$/   contains=@wikiText
" highlight only bullets and digits.
let g:vimwiki_rxListBullet = '^\s\+\*'
let g:vimwiki_rxListNumber = '^\s\+#'

" Treat all other lines that start with spaces as PRE-formatted text.
let g:vimwiki_rxPre1 = '^\s\+[^[:blank:]*#].*$'

" Preformatted text
let g:vimwiki_rxPreStart = '{{{'
let g:vimwiki_rxPreEnd = '}}}'

" Header's folding
let g:vimwiki_rxFoldH1Start = '^=[^=]\+.*=\s*$'
let g:vimwiki_rxFoldH1End = '^=[^=]\+=\s*$'

let g:vimwiki_rxFoldH2Start = '^==[^=]\+.*==\s*$'
let g:vimwiki_rxFoldH2End = '^==\{,1}[^=]\+.*==\{,1}\s*$'

let g:vimwiki_rxFoldH3Start = '^===[^=]\+.*===\s*$'
let g:vimwiki_rxFoldH3End = '^==\{,2}[^=]\+.*==\{,2}\s*$'

let g:vimwiki_rxFoldH4Start = '^====[^=]\+.*====\s*$'
let g:vimwiki_rxFoldH4End = '^==\{,3}[^=]\+.*==\{,4}\s*$'

let g:vimwiki_rxFoldH5Start = '^=====[^=]\+.*=====\s*$'
let g:vimwiki_rxFoldH5End = '^==\{,4}[^=]\+.*==\{,4}\s*$'

let g:vimwiki_rxFoldH6Start = '^======[^=]\+.*======\s*$'
let g:vimwiki_rxFoldH6End = '^==\{,5}[^=]\+.*==\{,5}\s*$'

" vim:tw=0:
