" Vundle things
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'Valloric/YouCompleteMe'

filetype plugin indent on


" for modeline...
set modeline modelines=5
" for line numbers
set nu

set fileencodings=utf-8,euc-cn

syntax on

" enable colorscheme if terminal supports color
if $TERM == 'fbterm' || $TERM == 'xterm+256color' || $TERM == 'xterm-256color'
    colo zenburn
endif


" font
if has("gui_running")
    set gfn=Courier\ 14
    set gfw=Microsoft\ YaHei\ 14,WenQuanYi\ Micro\ Hei\ 14

    behave mswin
endif

call pathogen#infect()


" vim:ai:et:ts=4:sw=4:sts=4:ff=unix:
