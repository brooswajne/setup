" load all plugins (in ~/.vim/bundle)
execute pathogen#infect() 

syntax on                 " syntax highlighting
filetype plugin indent on " file detection

set number relativenumber " line numbers (relative to current line)
augroup numbertoggle      " absolute line numbers when in insert mode
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set undodir=~/.vimdid " directory to store undo history
set undofile          " persist undo history after closing files

set tabstop=4         " changes width of tab character
set softtabstop=4     " changes how far inserted tab characters move the cursor
set shiftwidth=4      " affects automatic indentation, and when pressing <<, >>, or ==
set noexpandtab       " don't turn tabs into spaces

set scrolloff=3       " always keep n lines above/below the cursor when scrolling
set foldmethod=indent " folding based on indent
set nowrap            " avoid wrapping when text is off the edge

set laststatus=2      " always display status line (needed for lightline)
set showcmd           " shows the current command at the bottom right
set noshowmode        " hides the current mode (redundant thanks to lightline)
set signcolumn=yes    " avoid signcolumn pushing everything right once it shows (always show it)

set updatetime=300    " updates swap file more often, so git gutter is more in sync
set re=0              " use new regexp engine which fixes yats.vim perf issues
set splitright        " vertical splits open to the right
set splitbelow        " horizontal splits open below

set guicursor=a:block " for nvim, avoid a thin cursor in insert mode
set nofoldenable      " don't fold files by default when opening them

" =======
" Keymaps
" =======

let mapleader="\<Space>"

" quicker commands
nnoremap ; :
vnoremap ; :
" quicker escape
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
" quick switch between buffers
nnoremap <Leader><Leader> <C-^>
" quick-save
nnoremap <Leader>w :w<CR>
" quick-macros
nnoremap <Leader>q qa
nnoremap <Leader>p @a
vnoremap <Leader>p :normal @a<CR>
" jump to start/end of line easier
noremap H ^
noremap L $
" jump up/down page easier
nnoremap J <C-d>
nnoremap K <C-u>
" still allow me to jump to top/end of visible screen
nnoremap <Leader>j H
nnoremap <Leader>k L
nnoremap <Leader>J J
" avoid using arrow keys for navigation by remapping them
" instead, use them for navigating splits
nnoremap <left>  <C-W><C-h>
nnoremap <down>  <C-W><C-j>
nnoremap <up>    <C-W><C-k>
nnoremap <right> <C-W><C-l>
" edit/save vimrc
nnoremap <Leader>ve :edit $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>
" folding control
nnoremap <Leader>[ zc
nnoremap <Leader>{ zM
nnoremap <Leader>] zo
nnoremap <Leader>} zR
" search hotkeys
map <C-p> :Files<CR>
map <C-o> :Buffers<CR>
map <C-l> :Rg<CR>
" jump to coc diagnostics etc
nmap <Leader>, <Plug>(coc-diagnostic-prev)
nmap <Leader>. <Plug>(coc-diagnostic-next)
nmap <Leader>< <Plug>(coc-git-prevconflict)
nmap <Leader>> <Plug>(coc-git-nextconflict)
nmap <Leader>/ <Plug>(coc-definition)
nmap <Leader>? <Plug>(coc-type-definition)
" scroll coc popups
nnoremap <expr><C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nnoremap <expr><C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <expr><up>   coc#float#has_scroll() ? coc#float#scroll(1) : "\<up>"
inoremap <expr><down> coc#float#has_scroll() ? coc#float#scroll(0) : "\<down>"
" rename symbol
nmap <Leader>rn <Plug>(coc-rename)
" view documentation symbol (function defined in plugins)
nnoremap <Leader>' :call <SID>view_docs()<CR>
" easy aligning
if exists(":Tabularize")
	" align at = signs
	nnoremap <Leader>a= :Tabularize /=<CR>
	vnoremap <Leader>a= :Tabularize /=<CR>
	" align with character after :
	nnoremap <Leader>a: :Tabularize /:\zs<CR>
	vnoremap <Leader>a: :Tabularize /:\zs<CR>
endif

" ======
" Colors
" ======

highlight VertSplit  ctermbg=232 ctermfg=232
highlight SignColumn ctermbg=233
highlight LineNr     ctermbg=234 ctermfg=grey
highlight Folded     ctermbg=233 ctermfg=239

" highlight the current line number
set cursorline
if exists('&cursorlineopt')
	set cursorlineopt=number
endif
highlight clear CursorLine
highlight CursorLineNR cterm=bold ctermfg=yellow ctermbg=235

" gitgutter styling
let g:gitgutter_set_sign_backgrounds = 1
highlight GitGutterAdd    ctermbg=233 cterm=bold ctermfg=green 
highlight GitGutterChange ctermbg=233 cterm=bold ctermfg=yellow
highlight GitGutterDelete ctermbg=233 cterm=bold ctermfg=red

" coc styling
highlight CocFloating    ctermbg=233
highlight CocErrorSign   ctermbg=233
highlight CocWarningSign ctermbg=233
highlight CocInfoSign    ctermbg=233
highlight CocHintSign    ctermbg=233

" =======
" Plugins
" =======
" current list (2021-03-03):
"" :r !exa -1a ~/.vim/bundle | awk '{ print "" - "$0 }'
" - coc.nvim
" - editorconfig-vim
" - fzf
" - fzf.vim
" - Jenkinsfile-vim-syntax
" - lightline.vim
" - rust.vim
" - tabular
" - vim-commentary
" - vim-fugitive
" - vim-gitgutter
" - vim-highlightedyank
" - vim-markdown
" - vim-rooter
" - vim-sneak
" - vim-toml

" vim-sneak: re-tapping s jumps to next match
let g:sneak#s_next = 1

" lightline: configure status bar (coc diagnostics)
let g:lightline = {
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'readonly', 'filename', 'modified' ],
			\             [ 'git_blame' ] ],
			\   'right': [ [ 'lineinfo' ],
			\              [ 'coc_errors', 'coc_warnings', 'coc_hints', 'coc_infos' ],
			\              [ 'fileformat', 'fileencoding', 'filetype' ] ]
			\ },
			\ 'component_expand':  {
			\   'git_blame':    'LightlineGitBlame',
			\   'coc_errors':   'LightlineCocErrors',
			\   'coc_warnings': 'LightlineCocWarnings',
			\   'coc_hints':    'LightlineCocHints',
			\   'coc_infos':    'LightlineCocInfos',
			\ },
			\ 'component_type': {
			\   'coc_errors':   'error',
			\   'coc_warnings': 'warning',
			\   'coc_hints':    'tabsel',
			\   'coc_infos':    'middle',
			\ },
			\ }
autocmd User CocDiagnosticChange call lightline#update()
autocmd User CocGitStatusChange  call lightline#update()
function! LightlineGitBlame() abort
	let blame = get(b:, 'coc_git_blame', '')
	let width_blame = strlen(blame)
	let width_avail = winwidth(0) - 80
	return width_blame > width_avail ? blame[0:width_avail - 3] . '...' : blame
endfunction
function! LightlineCocErrors() abort
	return s:lightline_coc_diagnostic('error')
endfunction
function! LightlineCocWarnings() abort
	return s:lightline_coc_diagnostic('warning')
endfunction
function! LightlineCocHints() abort
	return s:lightline_coc_diagnostic('hint')
endfunction
function! LightlineCocWarnings() abort
	return s:lightline_coc_diagnostic('information')
endfunction
function! s:lightline_coc_diagnostic(type) abort
	let diagnostics = get(b:, 'coc_diagnostic_info', 0)
	if empty(diagnostics) || get(diagnostics, a:type, 0) == 0
		return ''
	endif
	return printf('● %d', diagnostics[a:type])
endfunction

" lightline: add command to quick-reload
command! LightlineReload call LightlineReload()
function! LightlineReload()
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
endfunction

" coc: avoid cursor weirdness when opening lists
let g:coc_disable_transparent_cursor = 1

" coc: use tab to trigger completion
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc: view documentation
function! s:view_docs()
	let is_vimfile = index([ 'vim', 'help'], &filetype) >= 0
	if is_vimfile
		" in vim files, show help for word under cursor
		execute 'h '.expand('<cword>')
	else
		" otherwise, show coc hover info
		call CocAction('doHover')
	endif
endfunction
