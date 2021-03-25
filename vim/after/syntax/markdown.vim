let g:language_aliases = {
			\ 'css': [ ],
			\ 'html': [ ],
			\ 'javascript': [ 'js' ],
			\ 'python': [ ],
			\ 'sh': [ 'bash', 'zsh' ],
			\ 'sql': [ 'psql' ],
			\ 'typescript': [ 'ts' ],
			\ }
let b:loaded_markdown_syntax_includes = 1
if !exists('b:loaded_javascript_syntax_includes')
	for [ language, aliases ] in items(g:language_aliases)
		call SyntaxRange#Include('/* '.language.' */`', '`', language)
		for alias in aliases
			call SyntaxRange#Include('/* '.alias.' */`', '`', language)
		endfor
	endfor
endif
unlet b:loaded_markdown_syntax_includes
