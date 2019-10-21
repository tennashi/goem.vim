" goem.vim
" Author: tennashi <yuya.gt@gmail.com>
" Licence: MIT

scriptencoding utf-8
if exists('g:loaded_goem') && g:loaded_goem
  finish
endif
let g:loaded_goem = 1
let s:save_cpo = &cpo
set cpo&vim

command! GoemList call goem#list_maildir()

augroup PluginGoem
  autocmd!
  autocmd BufReadCmd goem://* call goem#render(expand('<amatch>'))
  autocmd BufWriteCmd goem://* call goem#write(expand('<amatch>'))
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
