if exists('g:loaded_highlight') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

au BufWinEnter * lua require 'highlight'.attach()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_highlight = 1
