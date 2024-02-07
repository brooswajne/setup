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

function! SetupWrapping()
	setlocal wrap linebreak
	nnoremap <buffer> <expr> j v:count ? 'j' : 'gj'
	nnoremap <buffer> <expr> k v:count ? 'k' : 'gk'
endfunction
augroup wrapping " line-wrapping for text-based files
	autocmd Filetype text     call SetupWrapping()
	autocmd Filetype markdown call SetupWrapping()
	autocmd Filetype html     call SetupWrapping()
augroup END

augroup indentation " space vs tab indentation
	autocmd Filetype markdown setlocal expandtab
augroup END

set undodir=~/.vimdid " directory to store undo history
set undofile          " persist undo history after closing files

set list listchars=tab:»-,trail:·
set tabstop=4         " changes width of tab character
set softtabstop=4     " changes how far inserted tab characters move the cursor
set shiftwidth=4      " affects automatic indentation, and when pressing <<, >>, or ==
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
set mouse=            " for nvim, i don't like mice
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

function! TrimTrailingWhitespace()
	let l:winview = winsaveview()
	silent! %s/\s\+$//
	" restore original cursor position
	call winrestview(l:winview)
endfunction
command TrTr :call TrimTrailingWhitespace()
autocmd BufWritePre * :call TrimTrailingWhitespace()

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
" also in terminal mode
tnoremap <Esc> <C-\><C-n>
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
" lsp commands
nnoremap <Leader>, <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <Leader>. <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <Leader>l <cmd>lua vim.diagnostic.open_float(nil, { focus = false })<CR>
nnoremap <Leader>/ <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>? <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <Leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>' <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>" <cmd>lua vim.lsp.buf.code_action()<CR>
" search for conflict markers
nmap <Leader>> />>>>>><CR>
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

" ===============
" Language Server
" ===============

lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function(client, bufnr)
	-- if possible: format on save
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_exec([[
			augroup lsp_format_on_save
				autocmd BufWritePre * lua vim.lsp.buf.format(nil, 1000)
			augroup END
		]], false)
	else
		vim.api.nvim_exec([[
			augroup lsp_format_on_save
				autocmd!
			augroup END
		]], false)
	end

	-- if possible: highlight hovered symbol
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_exec([[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
	else
		vim.api.nvim_exec([[
			augroup lsp_document_highlight
				autocmd!
			augroup END
		]], false)
	end
end

local cfg = { on_attach = on_attach, capabilities = capabilities }
local lsp = require('lspconfig')
lsp.ansiblels.setup(cfg)      -- Ansible
lsp.bashls.setup(cfg)         -- Bash
lsp.clangd.setup(cfg)         -- C++
lsp.cmake.setup(cfg)          -- CMake
lsp.denols.setup(cfg)         -- TypeScript (Deno)
lsp.eslint.setup(cfg)         -- JavaScript (ESlint)
lsp.gopls.setup(cfg)          -- Go
lsp.jdtls.setup(cfg)          -- Java
lsp.kotlin_language_server.setup(cfg) -- Kotlin
lsp.phpactor.setup(cfg)       -- PHP
lsp.pyright.setup(cfg)        -- Pyright
lsp.tsserver.setup({          -- TypeScript (Node)
	cfg,
	root_dir = lsp.util.root_pattern('package.json'),
})
lsp.vimls.setup(cfg)          -- VimScript
require('rust-tools').setup({ -- Rust
	tools = {
		autoSetHints = true,
		inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},
	server = {
		cfg,
		standalone = true, -- standalone file support
		settings = {
			[ 'rust-analyzer' ] = {
				checkOnSave = { command = 'clippy' },
			},
		},
	},
})

-- Completions
local cmp = require('cmp')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		[ '<Tab>' ] = cmp.mapping.select_next_item(),
	}),
	sources = {
		{ name = "copilot" },
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer' },
	},
})

-- Copilot
require('copilot').setup({
	-- Superceded by copilot-cmp
	suggestion = { enabled = false },
	panel = { enabled = false },
})
require('copilot_cmp').setup({})
EOF

" format on save for eslint - is this needed?
" autocmd BufWritePre *.ts,*.js EslintFixAll

" ===========
" Tree-Sitter
" ===========

lua << EOF
require('nvim-treesitter.configs').setup({
	ensure_installed = {
		"bash",
		"go",
		"javascript",
		"lua",
		"python",
		"rust",
		"typescript",
		"vim",
	},
})
EOF

" =======
" Plugins
" =======

" nvim-cmp: completions options
set completeopt=menuone,noinsert,noselect

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

" lightline: configure status bar (diagnostics)
let g:lightline = {
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'readonly', 'filename', 'modified' ],
			\             [ 'git_blame' ] ],
			\   'right': [ [ 'lineinfo' ],
			\              [ 'lsp_errors', 'lsp_warnings', 'lsp_hints', 'lsp_infos' ],
			\              [ 'fileformat', 'fileencoding', 'filetype' ] ],
			\ },
			\ 'component_expand':  {
			\   'git_blame':    'LightlineGitBlame',
			\   'lsp_errors':   'LightlineLspErrors',
			\   'lsp_warnings': 'LightlineLspWarnings',
			\   'lsp_hints':    'LightlineLspHints',
			\   'lsp_infos':    'LightlineLspInfo',
			\ },
			\ 'component_type': {
			\   'lsp_errors':   'error',
			\   'lsp_warnings': 'warning',
			\   'lsp_hints':    'tabsel',
			\   'lsp_infos':    'middle',
			\   'lsp_status':   'tabsel',
			\ },
			\ }
autocmd DiagnosticChanged * call lightline#update()
autocmd CursorHold *        call lightline#update()
function! LightlineGitBlame() abort
	let file = expand('%')
	let line = line('.')

	" estimate of the space we have available for the git blame message
	" estimating space used by other components to about ~50 chars
	let width_avail = winwidth(0) - 50 - strlen(file)

	" get git blame details
	let details = gitblame#commit_summary(file, line)
	" format message
	if has_key(details, 'error')
		let blame = details['error']
	else
		let hash = details['commit_hash'][0:8]
		let author = width_avail < 128 ? split(details['author'])[0] : details['author']
		let timestamp = width_avail < 64 ? split(details['author_time'])[0] : details['author_time']
		let date = width_avail < 32 ? '' : ' '.timestamp
		let blame = hash.' ('.author.date.') '.details['summary']
	endif

	" truncate if necessary
	let width_blame = strlen(blame)
	return width_blame > width_avail ? blame[0:width_avail - 3] . '...' : blame
endfunction
function! LightlineLspErrors() abort
	return s:lightline_lsp_diagnostic('ERROR')
endfunction
function! LightlineLspWarnings() abort
	return s:lightline_lsp_diagnostic('WARN')
endfunction
function! LightlineLspHints() abort
	return s:lightline_lsp_diagnostic('HINT')
endfunction
function! LightlineLspWarnings() abort
	return s:lightline_lsp_diagnostic('INFO')
endfunction
function! s:lightline_lsp_diagnostic(level) abort
	let l:diagnostics = luaeval('vim.diagnostic.get('.bufnr().', { severity = vim.diagnostic.severity.'.a:level.'})')
	let l:count = len(l:diagnostics)
	return l:count == 0 ? '' : printf('● %d', l:count)
endfunction

" lightline: add command to quick-reload
command! LightlineReload call LightlineReload()
function! LightlineReload()
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
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
