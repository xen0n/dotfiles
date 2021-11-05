" https://github.com/vim/vim/issues/3117
if has('python3') && !has('patch-8.1.201')
    silent! python3 1
endif

" Vundle things
set nocompatible

call plug#begin('~/.vim/bundle')

function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" https://stackoverflow.com/questions/3098521/how-to-detect-if-a-specific-file-exists-in-vimscript
function! HaveFcitx()
    return isdirectory('/usr/share/fcitx')
endfunction

Plug 'tpope/vim-sensible'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-scripts/fcitx.vim', Cond(has('linux') && HaveFcitx())
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/Emmet.vim'
Plug 'tpope/vim-fugitive'
"Plug 'bling/vim-airline'
Plug 'Lokaltog/powerline'
Plug 'terryma/vim-smooth-scroll'
"Plug 'klen/python-mode'
Plug 'lifepillar/vim-solarized8'
Plug 'eapache/rainbow_parentheses.vim'
Plug 'digitaltoad/vim-jade'
Plug 'kchmck/vim-coffee-script'
Plug 'editorconfig/editorconfig-vim'
Plug 'saltstack/salt-vim'
Plug 'rust-lang/rust.vim'
Plug 'tfnico/vim-gradle'
Plug 'cespare/vim-toml'
Plug 'vim-latex/vim-latex'
Plug 'Yggdroot/indentLine'
Plug 'tmux-plugins/vim-tmux'
Plug 'vim-scripts/proguard.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'fatih/vim-go'
Plug 'bytecodealliance/cranelift.vim'

Plug 'wakatime/vim-wakatime'

Plug 'xen0n/bpl.vim'

Plug 'xen0n/xen0n-lyrics'
Plug 'xen0n/maidata.vim'

call plug#end()

" general settings that'd make people happy
set modeline modelines=5
set mouse=a
set nu
set fileencodings=utf-8,euc-cn
" set smartindent
set list

set foldmethod=marker

" only write file once when saving
set nowritebackup

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

" shortcut for :w then :make p on TeX files
command SaveAndPreview w | !make p
autocmd FileType tex nnoremap <Leader>p :SaveAndPreview<CR>

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

noremap <C-LEFT> <C-w>h
noremap <C-DOWN> <C-w>j
noremap <C-UP> <C-w>k
noremap <C-RIGHT> <C-w>l

autocmd FileType html set ai et ts=2 sw=2 sts=2
autocmd FileType json set ai et ts=2 sw=2 sts=2
autocmd FileType javascript set ai et ts=2 sw=2 sts=2
autocmd FileType css set ai et ts=2 sw=2 sts=2
autocmd FileType scss set ai et ts=2 sw=2 sts=2
autocmd FileType groovy set ai et
autocmd FileType java set ai et
autocmd FileType tex set ai et ts=2 sw=2 sts=2
autocmd FileType plaintex set ai et ts=2 sw=2 sts=2
autocmd FileType bib set ai et ts=2 sw=2 sts=2

" autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
autocmd BufNewFile,BufReadPost *.coffee setl et sw=2

autocmd BufNewFile,BufReadPost *.pro setl ft=proguard

" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2

" YCM
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_python_binary_path = 'python'  " for correct completion inside venv
" let YCM figure out the correct sysroot itself
" let g:ycm_rust_src_path = ''
let g:ycm_language_server =
\ [
\   {
\     'name': 'rust',
\     'cmdline': ['rust-analyzer'],
\     'filetypes': ['rust'],
\     'project_root_files': ['Cargo.toml']
\   }
\ ]
let g:ycm_extra_conf_globlist = ['~/src/oss/own/loongson/binutils-gdb/*','!~/*']

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
au FileType htmldjango RainbowParenthesesToggle
au FileType wast RainbowParenthesesToggle
"au FileType maidata RainbowParenthesesToggle
au FileType cmake RainbowParenthesesToggle

" diff files have no guarantees of balanced parens, so disable rainbow parens
" on these too
au FileType diff RainbowParenthesesToggle

" Go
let g:go_fmt_command = "goimports"
let g:go_imports_autosave = 1
let g:go_imports_mode = "goimports"

if has('mac')
    let g:go_bin_path = "/Users/xenon/go/bin"
elseif has('linux')
    let g:go_bin_path = "/home/xenon/go/bin"
endif

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
if $TERM == 'fbterm' || $TERM =~# '256color'
    " FIXME: This wouldn't work if put after colorscheme command...
    highlight ColorColumn ctermbg=234

    "colo zenburn
    set background=dark
    " used solarized for terminator... no need for the fallback any more
    " let g:solarized_termcolors=256

    " But let's preserve transparency...
    let g:solarized_termtrans=1
    colo solarized8
endif


" font
if has("gui_running")
    " set gfn=Courier\ 14
    set gfn=Source\ Code\ Pro\ Light\ 14
    set gfw=Source\ Han\ Sans\ 14

    behave mswin
endif

" indentLine
let g:indentLine_setColors = 0
let g:indentLine_char = '│'


"call pathogen#infect()

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

function! s:syntax_query() abort
    for id in synstack(line("."), col("."))
        echo synIDattr(id, "name")
    endfor
endfunction
command! SyntaxQuery call s:syntax_query()

" vim:ai:et:ts=4:sw=4:sts=4:ff=unix:
