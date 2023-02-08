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

if has('nvim')
    Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
else
    Plug 'Lokaltog/powerline'
    Plug 'Valloric/YouCompleteMe'
endif

Plug 'tpope/vim-sensible'
Plug 'vim-scripts/fcitx.vim', Cond(has('linux') && HaveFcitx())
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/Emmet.vim'
Plug 'tpope/vim-fugitive'
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
Plug 'xen0n/vim-asm-loongarch'

call plug#end()

" general settings that'd make people happy
set modeline modelines=5
set mouse=a
set nu
set fileencodings=utf-8,euc-cn
set list
" https://vi.stackexchange.com/questions/16148/slow-vim-escape-from-insert-mode
set ttimeoutlen=10

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

" shortcut for :w then :make p on TeX files
command SaveAndPreview w | !make p
autocmd FileType tex nnoremap <Leader>p :SaveAndPreview<CR>

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

autocmd BufNewFile,BufReadPost *.coffee setl et sw=2

autocmd BufNewFile,BufReadPost *.pro setl ft=proguard

if !has('nvim')
    " Powerline
    set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
    set laststatus=2

    " YCM
    let g:ycm_autoclose_preview_window_after_insertion=1
    let g:ycm_python_binary_path = 'python'  " for correct completion inside venv
    " let YCM figure out the correct sysroot itself
    " let g:ycm_rust_src_path = ''
    "let g:ycm_language_server =
    "\ [
    "\   {
    "\     'name': 'rust',
    "\     'cmdline': ['rust-analyzer'],
    "\     'filetypes': ['rust'],
    "\     'project_root_files': ['Cargo.toml']
    "\   }
    "\ ]
    "let g:ycm_rust_toolchain_root = '~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu'
    "let g:ycm_extra_conf_globlist = ['~/src/oss/own/loongson/binutils-gdb/*','!~/*']
    let g:ycm_gopls_binary_path = 'gopls' " search in $PATH
    let g:ycm_extra_conf_globlist = ['~/src/*','~/store/src/*']
endif

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

" enable colorscheme if terminal supports color
if $TERM == 'fbterm' || $TERM =~# '256color'
    " FIXME: This wouldn't work if put after colorscheme command...
    highlight ColorColumn ctermbg=234

    set background=dark
    let g:solarized_termtrans=1
    colo solarized8
endif


" font
if has("gui_running")
    set gfn=Source\ Code\ Pro\ Light\ 14
    set gfw=Source\ Han\ Sans\ 14

    behave mswin
endif

" indentLine
let g:indentLine_setColors = 0
let g:indentLine_char = '│'


function! s:syntax_query() abort
    for id in synstack(line("."), col("."))
        echo synIDattr(id, "name")
    endfor
endfunction
command! SyntaxQuery call s:syntax_query()

" vim:ai:et:ts=4:sw=4:sts=4:ff=unix:
