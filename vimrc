set nocompatible

call pathogen#incubate()
call pathogen#helptags()

set shortmess+=|
set mouse=a
set hlsearch
set incsearch

set noerrorbells 
set visualbell
"set t_vb= 

set tabstop=4
set shiftwidth=4
set smarttab
set smartindent

set laststatus=2
set encoding=utf-8
set noautoread
"set showtabline=2
  
set autoindent
filetype on
filetype plugin on
filetype indent on
set ignorecase
set smartcase
set textwidth=0
set nowrap
set number
set scrolljump=1
set path=.,,**

set scrolloff=3
"allow backspacing over everything in insert mode
set backspace=indent,eol,start
set complete-=k complete+=k

set ignorecase
set showmode    "show current mode down the bottom
set showcmd     "show incomplete cmds down the bottom
set ruler
set showmatch
syntax on
set background=light

set foldenable
set foldmethod=syntax
set foldcolumn=2
set foldlevel=1
let php_folding=1
set foldopen=all 

let mojo_highlight_data=1
au BufRead,BufNewFile *.epl   set filetype=html.epl
au BufRead,BufNewFile *.ep    set filetype=html.epl
au BufRead,BufNewFile Rexfile set filetype=perl

set wildmenu
set wildmode=full

set diffopt=filler,context:5,icase,iwhite,vertical

map <cr> i<cr><esc>

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

hi def link PerlString Comment
hi def link PerlComment Comment
hi DiffChange   ctermbg=LightMagenta	guibg=LightMagenta
hi DiffText   ctermbg=Magenta	guibg=Magenta

inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>

iab <expr> xt strftime("%H:%M:%S")
iab <expr> xd strftime("%Y-%m-%d")

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

