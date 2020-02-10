set nocompatible

set shell=/bin/bash\ -i

call pathogen#incubate()
call pathogen#helptags()

set shortmess+=|
set mouse=a
set hlsearch
set incsearch
set bg=light

set t_Co=256
"colorscheme distinguished

set noerrorbells 
set visualbell
"set t_vb= 

set tabstop=4
set shiftwidth=4
set smarttab
set smartindent
set expandtab
"set noexpandtab

set laststatus=2
set encoding=utf-8
set noautoread
"set showtabline=2
  
set autoindent
"set autochdir
filetype on
filetype plugin on
filetype indent on
set fileformat=unix
set fileformats=unix,dos
set ignorecase
set smartcase
set textwidth=0
set nowrap
set number
set scrolljump=1
set path=.,,**

set scrolloff=0
"set scrolloff=9999 " to hold cursor in the middle of screen
"allow backspacing over everything in insert mode
set backspace=indent,eol,start
set complete-=k complete+=k

set showmode    "show current mode down the bottom
set showcmd     "show incomplete cmds down the bottom
set ruler
set showmatch
syntax on
set background=light

set nocursorcolumn
set cursorline
set norelativenumber
syntax sync minlines=256

set nofoldenable
"set foldenable=0
"set foldmethod=syntax
"set foldcolumn=2
"set foldlevel=1
"let php_folding=1
"set foldopen=all 
"set rnu

set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

"let g:netrw_list_hide='[\/]$,\<core\%(\.\d\+\)\=,\.[a-np-z]$,\.h$,\.c$,\.cpp$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$'
"let g:netrw_list_hide='[\/]$,\<core\%(\.\d\+\)\=,\.swp$,\.bak$,\~$'
let g:netrw_list_hide='^\.\/$,\.swp$,\.bak$,\.\.,\~'
let g:tsuquyomi_definition_split=3
let g:tsuquyomi_disable_quickfix = 1

"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set statusline=%<%f\ %h%m%r(%{fugitive#head(7)})%=%-14.(%l,%c%V%)\ %P
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let SyntasticToggleMode='passive'
" let g:syntastic_disabled_filetypes=[]
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

" let mojo_highlight_data=1

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_debug = 32  "debug checkers
" let g:syntastic_loc_list_height = 7
" let g:syntastic_aggregate_errors = 1
"let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exec = '/usr/bin/eslint'

"let g:syntastic_error_symbol = '❌'
" let g:syntastic_error_symbol = 'XX'
"let g:syntastic_style_error_symbol = '⁉️'
" let g:syntastic_style_error_symbol = '??'
"let g:syntastic_warning_symbol = '⚠️'
" let g:syntastic_warning_symbol = '!!'
"let g:syntastic_style_warning_symbol = '💩'
" let g:syntastic_style_warning_symbol = '#%'

" let g:syntastic_aggregate_errors = 1

let g:LoupeVeryMagic=0

" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn

" let g:syntastic_css_checkers = ['csslint']
" let g:loaded_syntastic_notifier_cursor = 1
" let g:loaded_syntastic_javascript_jsxhint_checker=1 "get rid of buggy checker
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_open_new_file = 't'
let g:ctrlp_custom_ignore = {'dir': '\v[\/]node_modules$'}
au BufRead,BufNewFile *.epl   set filetype=html.epl
au BufRead,BufNewFile *.ep    set filetype=html.epl
au BufRead,BufNewFile Rexfile set filetype=perl
au BufNewFile,BufRead *.ejs   set filetype=html
au BufNewFile,BufRead *.cjsx set filetype=javascript.jsx
au BufRead,BufNewFile *.coffee set filetype=javascript.coffee
au BufRead,BufNewFile *.module set filetype=php
au BufRead,BufNewFile *.ts set filetype=typescript
au BufRead,BufNewFile *.twig set filetype=html

autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_verbose=0
"let g:neomake_verbose=3
let g:neomake_open_list = 0
let g:neomake_list_height = 4
let g:neomake_javascript_enabled_makers = ['eslint']

if !empty($PERL_BINARY)
	let g:Perl_Perl = $PERL_BINARY
endif

set wildmenu
set wildmode=full
set wildignorecase
set pastetoggle=<F2>

set diffopt=filler,context:5,icase,iwhite,vertical

map <cr> i<cr><esc>
map Q :w<cr>

" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv
 
" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

"these lines to prevent vim to remove tabs from empty lines

let Tlist_Ctags_Cmd='/usr/bin/ctags-exuberant'
let Tlist_Inc_Winwidth=0

highlight MatchParen ctermbg=blue guibg=lightyellow
"highlight CursorLine ctermbg=8 cterm=NONE
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'w')?('W'):('w'))
cnoreabbrev <expr> TABP ((getcmdtype() is# ':' && getcmdline() is# 'tabp')?('TABP'):('tabp'))
cnoreabbrev <expr> TABN ((getcmdtype() is# ':' && getcmdline() is# 'tabn')?('TABN'):('tabn'))
cnoreabbrev <expr> TABR ((getcmdtype() is# ':' && getcmdline() is# 'tabr')?('TABR'):('tabr'))
cnoreabbrev <expr> TABL ((getcmdtype() is# ':' && getcmdline() is# 'tabl')?('TABL'):('tabl'))
cnoreabbrev <expr> TABE ((getcmdtype() is# ':' && getcmdline() is# 'tabe')?('TABE'):('tabe'))

"hi PComment guifg=#5f5fff guibg=none guisp=none ctermfg=117 ctermbg=none
hi PComment guifg=#5f5fff guisp=none ctermfg=117 ctermbg=none
hi! link perlComment PComment

"hi PVariables guifg=#005f00 guibg=none guisp=none gui=bold ctermfg=30 ctermbg=none cterm=bold
"hi! link perlVarPlain PVariables

hi PFunction guisp=none ctermfg=30 ctermbg=none cterm=bold
hi! link perlSubName PFunction

"hi Type guifg=#008787 guibg=NONE guisp=NONE gui=bold ctermfg=30 ctermbg=NONE cterm=bold
"hi! link PerlString Type
"hi def link PerlString perlPackageRef
"hi def link PerlString perlPackageRef
"hi def link PerlComment Comment
hi DiffChange ctermbg=LightMagenta	guibg=LightMagenta
hi DiffText ctermbg=Magenta	guibg=Magenta
hi String ctermfg=Blue
hi Comment ctermfg=Gray

inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <F4> :tabs<CR>:tabn<Space>

iab <expr> xt strftime("%H:%M:%S")
iab <expr> xd strftime("%Y-%m-%d")

command JsBeautify call JsBeautify()
command CSSBeautify call CSSBeautify()
command HTMLBeautify call HtmlBeautify()

command -range=% RJsBeautify <line1>,<line2>call RangeJsBeautify()
command -range=% RCSSBeautify <line1>,<line2>call RangeCSSBeautify()
command -range=% RHTMLBeautify <line1>,<line2>call RangeHtmlBeautify()

function MyTabLine()
    let tabline = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let tabline .= '%#TabLineSel#'
        else
            let tabline .= '%#TabLine#'
        endif
        let tabline .= '%' . (i + 1) . 'T'
        let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
    endfor
    let tabline .= '%#TabLineFill#%T'
    if tabpagenr('$') > 1
        let tabline .= '%=%#TabLine#%999XX'
    endif
    return tabline
endfunction
function MyTabLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)
    let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')
    if label == ''
        let label = '[No Name]'
    endif
    let label .= ' (' . a:n . ')'
    for i in range(len(buflist))
        if getbufvar(buflist[i], "&modified")
            let label = '[+] ' . label
            break
        endif
    endfor
    return label
endfunction
function MyGuiTabLabel()
    return '%{MyTabLabel(' . tabpagenr() . ')}'
endfunction
set tabline=%!MyTabLine()
set guitablabel=%!MyGuiTabLabel()

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

function! s:Highlight_Matching_Pair()
endfunction

function! TabCloseRight(bang)
    let cur=tabpagenr()
    while cur < tabpagenr('$')
        exe 'tabclose' . a:bang . ' ' . (cur + 1)
    endwhile
endfunction

function! TabCloseLeft(bang)
    while tabpagenr() > 1
        exe 'tabclose' . a:bang . ' 1'
    endwhile
endfunction

command! -bang Tabcloseright call TabCloseRight('<bang>')
command! -bang Tabcloseleft call TabCloseLeft('<bang>')
