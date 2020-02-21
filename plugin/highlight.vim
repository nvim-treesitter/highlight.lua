if exists('g:loaded_highlight') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

" TODO: not sure about BufAdd
" au BufAdd * lua require 'highlight'.run()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_highlight = 1
