if exists('g:loaded_highlight') || !has('nvim-0.5')
   finish
endif

let s:save_cpo = &cpo
set cpo&vim

au BufWinEnter * lua require 'highlight'.attach()

function! InstallParser(lang)
    call luaeval("require 'highlight'.install_parser(_A)", a:lang)
endfunction

command! -nargs=1 InstallTSParser :call InstallParser(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_highlight = 1
