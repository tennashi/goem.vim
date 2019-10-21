scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#goem#new()

let s:list_mail_cmd = {
      \ 'bufnr' : 0,
      \ 'maildir_name': '',
      \ 'mails': [],
      \}

function! goem#command#list_mail#init(buf_name, maildir_name) abort
  let s:list_mail_cmd.bufnr = bufnr(a:buf_name)
  let s:list_mail_cmd.maildir_name = a:maildir_name
  let s:list_mail_cmd.mails = goem#api#fetch_mail(a:maildir_name)
  call s:list_mail_cmd._buffer_setting()
  call s:list_mail_cmd._key_mapping()
  return s:list_mail_cmd
endfunction

function! goem#command#list_mail#_get_mail_key(line_num) abort
  return s:list_mail_cmd.mails[a:line_num]['key']
endfunction

function! s:list_mail_cmd._buffer_setting() abort
  setlocal buftype=acwrite
  setlocal nonumber norelativenumber nowrap
endfunction

function! s:list_mail_cmd._key_mapping() abort
  nnoremap <buffer> <Enter>
        \ :<C-u>call goem#show_mail(goem#command#list_mail#_get_mail_key(winline()))<CR>
endfunction

function! s:list_mail_cmd.render() abort
  for mail in self.mails
    call appendbufline(self.bufnr, '$', "Subject: "..mail["subject"])
  endfor
  call deletebufline(self.bufnr, 1)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
