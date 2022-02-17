" load all plugins (in ~/.vim/bundle)
execute pathogen#infect() 

set nocompatible          " aka. 'enter the current millennium'
syntax on                 " syntax highlighting
filetype plugin indent on " file detection

set spellsuggest+=10      " limit height of spelling suggestions
set spelllang=en_gb       " spell-checking language
augroup spellchecker
	autocmd Filetype gitcommit setlocal spell spellcapcheck=
	autocmd Filetype text      setlocal spell
	autocmd Filetype markdown  setlocal spell
augroup END

set number relativenumber " line numbers (relative to current line)
augroup numbertoggle      " absolute line numbers when in insert mode
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

augroup wrapping " line-wrapping for text-based files
	autocmd Filetype text     setlocal wrap linebreak textwidth=80
	autocmd Filetype markdown setlocal wrap linebreak textwidth=80
augroup END

augroup indentation " space vs tab indentation
	autocmd Filetype markdown setlocal expandtab
augroup END

set undodir=~/.vimdid " directory to store undo history
set undofile          " persist undo history after closing files

set tabstop=2         " changes width of tab character
set softtabstop=2     " changes how far inserted tab characters move the cursor
set shiftwidth=2      " affects automatic indentation, and when pressing <<, >>, or ==
set noexpandtab       " don't turn tabs into spaces

set scrolloff=3       " always keep N lines above/below the cursor when scrolling
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
set conceallevel=0    " don't conceal things, i want to see them for what they are

" command tab completions listed better
set wildmenu
set wildmode=list:longest,full

" additional filetype detection
augroup more_filetypes
	autocmd!
	autocmd BufNewFile,BufRead *.cjs set filetype=javascript
augroup END

" =======
" Keymaps
" =======

let mapleader="\<Space>"

" check my spelling
nnoremap <Leader>c :setlocal spell!<CR>
" switch away and close
nnoremap <Leader>bd <C-^>:bd #<CR>
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
" quick-sort
vnoremap <Leader>s :sort<CR>
" quick-lines
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D
" quick-macros
nnoremap <Leader>q qa
nnoremap <Leader>p @a
vnoremap <Leader>p :normal @a<CR>
" stop searching easier
nnoremap <C-h> :nohlsearch<CR>
vnoremap <C-h> :nohlsearch<CR>
" centre search results vertically
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> g* g*zz
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
nnoremap <C-p> :Files<CR>
nnoremap <C-o> :Buffers<CR>
nnoremap <C-l> :Rg<CR>
nnoremap <C-k> :Rg <C-R><C-W><CR>
nnoremap <C-i> :BCommits<CR>
nnoremap <C-u> :Commits<CR>
" jump to coc diagnostics etc.
nmap <Leader>, <Plug>(coc-diagnostic-prev)
nmap <Leader>. <Plug>(coc-diagnostic-next)
nmap <Leader>< <Plug>(coc-git-prevconflict)
nmap <Leader>> <Plug>(coc-git-nextconflict)
nmap <Leader>/ <Plug>(coc-definition)
nmap <Leader>? <Plug>(coc-type-definition)
" scroll coc pop-ups
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" rename symbol
nmap <Leader>rn <Plug>(coc-rename)
" view documentation symbol (function defined in plugins)
nnoremap <Leader>' :call <SID>view_docs()<CR>
" align at = signs
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
" align with character after :
nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>

" =======
" Colours
" =======

set background=dark
" use 24 bit colours
if (has("termguicolors"))
	set termguicolors
endif

function! SetMyHighlighting()
	" transparent background
	highlight Normal     ctermbg=none  guibg=none

	highlight VertSplit  ctermbg=232   ctermfg=232 
	highlight VertSplit  guibg=#080808 guifg=#080808
	highlight SignColumn ctermbg=233
	highlight SignColumn guibg=#121212
	highlight LineNr     ctermbg=234   ctermfg=grey
	highlight LineNr     guibg=#080808 guifg=grey
	highlight Folded     ctermbg=233   ctermfg=239
	highlight Folded     guibg=#121212 guifg=#4e4e4e

	" highlight the current line number
	set cursorline
	if exists('&cursorlineopt')
		set cursorlineopt=number
	endif
	highlight clear CursorLine
	highlight CursorLineNR cterm=bold ctermfg=yellow ctermbg=235
	highlight CursorLineNR gui=bold   guifg=yellow   guibg=#262626

	" gitgutter styling
	let g:gitgutter_set_sign_backgrounds = 1
	highlight GitGutterAdd    ctermbg=233   cterm=bold ctermfg=green 
	highlight GitGutterAdd    guibg=#121212 gui=bold   guibg=green
	highlight GitGutterChange ctermbg=233   cterm=bold ctermfg=yellow
	highlight GitGutterChange guibg=#121212 gui=bold   guibg=yellow
	highlight GitGutterDelete ctermbg=233   cterm=bold ctermfg=red
	highlight GitGutterDelete guibg=#121212 gui=bold   guibg=red

	" coc styling
	highlight CocFloating    ctermbg=233 guibg=#121212
	highlight CocErrorSign   ctermbg=233 guibg=#121212
	highlight CocWarningSign ctermbg=233 guibg=#121212
	highlight CocInfoSign    ctermbg=233 guibg=#121212
	highlight CocHintSign    ctermbg=233 guibg=#121212
endfunction

if (has("autocmd") && !has("gui_running"))
	augroup colorset
		autocmd!
		" add my custom highlighting
		autocmd ColorScheme * call SetMyHighlighting()
	augroup END
endif

" set colorscheme
colorscheme space-vim-dark

" =======
" Plugins
" =======

" vim-sneak: re-tapping s jumps to next match
let g:sneak#s_next = 1

" vim-svelte-plugin: indentation style
let g:vim_svelte_plugin_has_init_indent = 0
" vim-svelte-plugin: support lang=ts
let g:vim_svelte_plugin_use_typescript = 1

" vim-rooter: use npm module as root
let g:rooter_patterns = ['.git', 'package.json']

" vim-terraform: align settings automatically
let g:terraform_align = 1
" vim-terraform: format on save
let g:terraform_fmt_on_save = 1

" vimwiki: don't use just <Leader> as a prefix, as it conflicts with my keybinds
let g:vimwiki_map_prefix = '<Leader>vw'
" vimwiki: don't use vimwiki filetype for non-vimwiki markdown files
let g:vimwiki_global_ext = 0
" vimwiki: path
let g:vimwiki_root = '~/wiki'
let g:vimwiki_list = [ {
			\ 'path': '~/wiki',
			\ 'syntax': 'markdown',
			\ 'ext': '.md',
			\ } ]

" don't force me to conceal when i don't want to:
" vimwiki: don't force me to conceal when i don't want to
let g:vimwiki_conceallevel = 0
" vim-json: don't force me to conceal when i don't want to
let g:vim_json_syntax_conceal = 0
" vim-markdown: don't force me to conceal when i don't want to
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

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

" vim-js-pretty-template: syntax highlighting for template literals
call jspretmpl#register_tag('css', 'css')
call jspretmpl#register_tag('html', 'html')
call jspretmpl#register_tag('sql', 'sql')
augroup tagged_templates
	autocmd!
	autocmd FileType javascript JsPreTmpl
	autocmd FileType typescript JsPreTmpl
augroup END
