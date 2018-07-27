" General Config
"let $VIM         = "$HOME"
"let $VIMRUNTIME  = "~/.vim/runtime"
"set runtimepath^=$VIMRUNTIME
"set helpfile=~/.vim/runtime/doc/help.txt
set number
set nocompatible
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
execute pathogen#infect()
" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif
set nobackup
set nowb
set noswapfile
set mouse=a
if has("syntax")
  syntax on
endif
set showcmd
set wildmenu
" Theme Config
" Enable syntax highlighting
set background=dark
" Enable 256 colors palette
if $COLORTERM == 'truecolor'
   set t_Co=256
endif
try
    colorscheme hybrid_material
    set termguicolors
catch
endtry

"" extra options
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
source $VIMRUNTIME/defaults.vim

" Airline Theme Config
" Install vim-airline, vim-airline-themes, 
" powerline-fonts, and powerline2
" let g:airline_theme='solarized'
 "let g:airline_theme = "default"
 let g:airline_powerline_fonts = 1
 "set laststatus=2

" Text Wrapping
set nowrap
set linebreak
set textwidth=0
set showbreak=>\ \ \
set colorcolumn=132

" Tabs/Spaces 
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab
set autoindent
set showmatch
set si
set wrap
set autoread

" Auto brackets
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"

" NERDTree
"let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=20
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" VIM Go
let g:go_fmt_command = "goimports"

" Omni complete (<C-X><C-O>)
set omnifunc=syntaxcomplete#Complete

" Git gutter (Git diff)
if executable('git')
  let g:gitgutter_enabled=-1
  nnoremap <silent> <leader>d :GitGutterToggle<cr>
endif
