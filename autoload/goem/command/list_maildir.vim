scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#goem#new()

let s:list_maildir_cmd = {
      \ 'bufnr' : 0,
      \ 'maildirs': [],
      \}

function! goem#command#list_maildir#init(buf_name) abort
  let s:list_maildir_cmd.bufnr = bufnr(a:buf_name)
  let s:list_maildir_cmd.maildirs = goem#api#fetch_maildir()
  call s:list_maildir_cmd._buffer_setting()
  call s:list_maildir_cmd._key_mapping()
  return s:list_maildir_cmd
endfunction

function! s:list_maildir_cmd._buffer_setting() abort
  setlocal buftype=acwrite
  setlocal nonumber norelativenumber nowrap nomodified noswapfile
endfunction

function! s:list_maildir_cmd._key_mapping() abort
  nnoremap <silent> <buffer> <Enter> :<C-u>call goem#list_mail(getline(winline()))<CR>
endfunction

function! s:list_maildir_cmd.render() abort
  for maildir in self.maildirs
    call appendbufline(self.bufnr, '$', maildir['name'])
  endfor
  call deletebufline(self.bufnr, 1)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
