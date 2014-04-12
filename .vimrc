" Vundle things
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'Valloric/YouCompleteMe'
Bundle 'fcitx.vim'
Bundle 'scrooloose/syntastic'
Bundle 'Emmet.vim'
Bundle 'tpope/vim-fugitive'
"Bundle 'bling/vim-airline'
Bundle 'Lokaltog/powerline'
Bundle 'terryma/vim-smooth-scroll'
Bundle 'klen/python-mode'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'kchmck/vim-coffee-script'

filetype plugin indent on

" general settings that'd make people happy
set modeline modelines=5
set mouse=a
set nu
set fileencodings=utf-8,euc-cn
" set smartindent

" referenced from yueyoum/dotfiles with some personal touch
set bs=indent,eol,start  " backspace
set tf  " ttyfast
set cc=79  " colorcolumn
set ts=4
set sw=4
set sts=4

"inoremap ( ()<LEFT>
"inoremap [ []<LEFT>
"inoremap { {}<LEFT>

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

noremap <C-LEFT> <C-w>h
noremap <C-DOWN> <C-w>j
noremap <C-UP> <C-w>k
noremap <C-RIGHT> <C-w>l

autocmd FileType json set ts=2 sw=2 sts=2
autocmd FileType javascript set ts=2 sw=2 sts=2
autocmd FileType css set ts=2 sw=2 sts=2
autocmd FileType scss set ts=2 sw=2 sts=2

autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
autocmd BufNewFile,BufReadPost *.coffee setl et sw=2

" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2

" YCM
let g:ycm_autoclose_preview_window_after_insertion=1

" Python mode
let g:pymode_run=0
let g:pymode_lint=0
let g:pymode_lintwrite=0
let g:pymode_rope=0

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggleAll
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Don't enable rainbow parentheses for the following filetypes, as it would
" interfere with proper coloring of these files.
au FileType css RainbowParenthesesToggle
au FileType gentoo-init-d RainbowParenthesesToggle
au FileType ebuild RainbowParenthesesToggle

" Vala settings
" Disable valadoc syntax highlight
"let vala_ignore_valadoc = 1

" Enable comment strings
let vala_comment_strings = 1

" Highlight space errors
let vala_space_errors = 1
" Disable trailing space errors
"let vala_no_trail_space_error = 1
" Disable space-tab-space errors
"let vala_no_tab_space_error = 1

" Minimum lines used for comment syncing (default 50)
"let vala_minlines = 120

syntax on

" enable colorscheme if terminal supports color
if $TERM == 'fbterm' || $TERM == 'xterm+256color' || $TERM == 'xterm-256color'
    " FIXME: This wouldn't work if put after colorscheme command...
    highlight ColorColumn ctermbg=234

    "colo zenburn
    set background=dark
    " used solarized for terminator... no need for the fallback any more
    " let g:solarized_termcolors=256

    " But let's preserve transparency...
    let g:solarized_termtrans=1
    colo solarized
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
