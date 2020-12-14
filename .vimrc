" load all plugins (in ~/.vim/bundle)
execute pathogen#infect() 

set number " line numbers
syntax on " syntax highlighting

filetype plugin indent on
set tabstop=4 " changes width of tab character
set shiftwidth=4 " affects automatic indentation, and when pressing <<, >>, or ==
set expandtab " don't use actual tab character when pressing TAB key

set scrolloff=3 " always keep n lines above/below the cursor when scrolling
set updatetime=100 " updates swap file more often, so git gutter is more in sync

" signs column (left of line numbers, for lint errors etc) has transparent bg
highlight clear SignColumn

" ale
let g:ale_linters = { 'javascript': [ 'eslint' ] }
let g:ale_sign_error   = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign   guibg=darkred ctermfg=red
highlight ALEWarningSign guibg=darkyellow ctermfg=yellow

" gitgutter
let g:gitgutter_set_sign_backgrounds = 1
highlight GitGutterAdd    guibg=darkgrey ctermfg=green
highlight GitGutterChange guibg=darkgrey ctermfg=yellow
highlight GitGutterDelete guibg=darkgrey ctermfg=red
