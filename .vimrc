	" [x] statusline
	" [x] comments (not necessary at last)
	" [x] autoclosingDone!
	" [x] competitive tricks + debug comments
	" [x] encircling

set nocompatible
set wildmenu
set encoding=utf-8
set autoindent
set exrc
set cursorline
set colorcolumn=80
set noerrorbells
set mouse=a
set ttymouse=sgr
set showcmd

set autoread
autocmd CursorHold * checktime

syntax on
filetype plugin on

set noexpandtab
set shiftwidth=8
set tabstop=8
set nowrap
set scrolloff=4

set incsearch
set smartcase
set showmatch

set noswapfile
set undofile
set undodir=~/.vim/undodir

set list
set listchars=tab:\|\ 

set splitright
set splitbelow
set foldmethod=marker

" LINE NUMBERS
set nu
set rnu

" GUI OPTIONS{{{
if has('gui_running')
	set guioptions-=T
	set guioptions-=m
	set guioptions-=r
	set guioptions-=L
	set guioptions-=e
	set guioptions+=c

	set guipty
	set guifont=Source\ Code\ Pro\ Medium\ 14
endif "}}}

" PATHS FOR FUZZY FIND
set path=/usr/include,$PWD/**
set wildignore+=**/node_modules/**

" VIM DIRECTORY
let g:vimdir = split(&runtimepath, ',')[0]

" PLUGINS
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'xavierd/clang_complete'
Plug 'preservim/tagbar'
Plug 'xuhdev/vim-latex-live-preview'

Plug $'{g:vimdir}/vim-plugins/autoclose'
Plug $'{g:vimdir}/vim-plugins/comment'
Plug $'{g:vimdir}/vim-plugins/statusline'
Plug $'{g:vimdir}/vim-plugins/enclose'
call plug#end()

" AUTOCLOSE
autocmd VimEnter * SetGenericAutoclose
autocmd FileType html SetHTMLAutoclose
autocmd FileType tex SetLatexAutoclose

" AUTOCOMPLETTION
set tags+=~/.vim/tags/cpp
set completeopt=menuone,longest
set shortmess+=c
set pumheight=20

" CLANG SETTINGS
let g:clang_library_path='/usr/lib'
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_close_preview=1
let g:clang_complete_macros=1
autocmd FileType cpp :let g:clang_user_options = '-std=c++11'
let g:clang_jumpto_declaration_key = ''

" COLORSCHEME
colo gruvbox
set background=dark

" COMMENTS
autocmd VimEnter * EnableCommenting
autocmd BufEnter * let b:doxygen_in_out=1

" COMPILATION
autocmd BufEnter * :nnoremap <F12> :make<CR>
let g:tex_flavor = "latex"
autocmd FileType tex :compiler tex
autocmd FileType python :compiler pyunit
autocmd FileType cpp :set makeprg=g++\ %\ -o\ %:r\ -Wall\ -std=c++11\ -DLOCAL\ -g\ -O2
autocmd FileType cpp :nnoremap <F12> :w <bar> make <bar> !./%:r<CR>

" FILE EXPLORER
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
nnoremap <Leader>f :Vex <CR>

" STATUSLINE
autocmd VimEnter * SetStatusLine

" TAGBAR SETTINGS
nnoremap <leader>tt :TagbarToggle<CR>

" -----SHORTCUTS-----

" SETTING WORKING DIRECTORY
autocmd VimEnter :lcd %:p:h
nnoremap <silent> <leader>cd :cd %:p:h<CR>:pwd<CR>

" GRACEFULLY EXIT
nnoremap <leader>q  :qa

" TEXT WRAPPING
autocmd FileType tex,md :set wrap
autocmd FileType tex,md :set textwidth=80
autocmd FileType tex,md :set formatoptions+=w

" LATEX
autocmd FileType tex :set makeprg=pdflatex\ -interaction=nonstopmode\ %
autocmd FileType tex :nnoremap <F12> :w <bar> make<CR>
autocmd FileType tex :nnoremap <leader>lp :LLPStartPreview<CR>

" FILE HANDLING
function! SearchOldFiles()
	let x = input("Give search param: ", "'/'")
	execute 'normal! :<Esc>'
	execute $'browse filter {x} oldfiles'
endfunction
nnoremap <leader>oo :ls<CR>:b<Space>
nnoremap <leader>or :call SearchOldFiles()<CR>
cnoremap bda bufdo bd

" COMPETITIVE PROGRAMMING MACROS
nnoremap <leader>sn :-1read ~/.vim/skeleton.
function! OpenIO()
	let x=input("Give filenames: ", expand("%:r"))
	execute $'40vs {x}.in | sp {x}.out'
endfunction
nnoremap <leader>io :call OpenIO()<CR>

" CONFIG RELOADING
nnoremap <silent> <leader>hr :so ~/.vimrc<CR>

" TERMINAL 
nnoremap <leader>tc :term ++curwin<CR>
nnoremap <leader>tn :tabnew <bar> term ++curwin<CR>

" SET FILETYPE FOR EJS
autocmd BufEnter *.ejs :set ft=html

" GO TO 
function! GoToDefinitions()"{{{
	if &ft == 'cpp' || &ft == 'c'
		let @/ = 'int[\ |\n]main'
		normal! ggn2k
	elseif &ft == 'javascript'
		let @/ = 'import\|require'
		normal! ggn
	endif
endfunction
function! GoToMain()
	if &ft == 'cpp' || &ft == 'c'
		let @/ = 'int[\ |\n]main'
		normal! ggn$
	endif
endfunction"}}}

nnoremap <silent> <leader>gd :call GoToDefinitions()<CR>
nnoremap <silent> <leader>gm :call GoToMain()<CR>

" CREATE TAGS FOR PROJECT
command! NodeTagConfig !cp ~/.vim/skeleton.nodejs.ctags ./.ctags && ctags -R .
nnoremap <silent> <leader>ct :!echo "CREATING TAGS..." && ctags -R .<CR>

" OPEN TODO / FIXME LIST
command! Todo noautocmd vimgrep /^\W*\(TODO\|@todo\|FIXME\)/j ** | cw
