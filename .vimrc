" Vundle things
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'Valloric/YouCompleteMe'
Bundle 'fcitx.vim'
Bundle 'scrooloose/syntastic'
Bundle 'ZenCoding.vim'
Bundle 'tpope/vim-fugitive'
"Bundle 'bling/vim-airline'
Bundle 'Lokaltog/powerline'

filetype plugin indent on

" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2

set modeline modelines=5
set mouse=a
set nu
set fileencodings=utf-8,euc-cn
" set smartindent

syntax on

" enable colorscheme if terminal supports color
if $TERM == 'fbterm' || $TERM == 'xterm+256color' || $TERM == 'xterm-256color'
    colo zenburn
endif


" font
if has("gui_running")
    " set gfn=Courier\ 14
    set gfn=Source\ Code\ Pro\ Light\ 14
    set gfw=Microsoft\ YaHei\ 14,WenQuanYi\ Micro\ Hei\ 14

    behave mswin
endif

call pathogen#infect()

" decided to also give powerline a shot
"" cool vim-airline settings
"" unicode symbols
"" let g:airline_left_sep = '»'
"" let g:airline_left_sep = '▶'
"" let g:airline_right_sep = '«'
"" let g:airline_right_sep = '◀'
"" let g:airline_linecolumn_prefix = '␊ '
"" let g:airline_linecolumn_prefix = '␤ '
"" let g:airline_linecolumn_prefix = '¶ '
"" let g:airline_fugitive_prefix = '⎇ '
"let g:airline_paste_symbol = 'ρ'
""let g:airline_paste_symbol = 'Þ'
""let g:airline_paste_symbol = '∥'
"
"" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_fugitive_prefix = ' '
"let g:airline_readonly_symbol = ''
"let g:airline_linecolumn_prefix = ' '


" vim:ai:et:ts=4:sw=4:sts=4:ff=unix:
