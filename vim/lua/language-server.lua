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
lsp.eslint.setup(cfg)         -- JavaScript (ESlint)
lsp.gopls.setup(cfg)          -- Go
lsp.jdtls.setup(cfg)          -- Java
lsp.kotlin_language_server.setup(cfg) -- Kotlin
lsp.phpactor.setup(cfg)       -- PHP
lsp.pyright.setup(cfg)        -- Pyright
lsp.ts_ls.setup(cfg)          -- TypeScript (Node)
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
