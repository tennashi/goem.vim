scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#goem#new()
let s:Base64 = s:V.import('Data.Base64')

let s:show_mail_cmd = {
      \ 'bufnr' : 0,
      \ 'maildir_name': '',
      \ 'mail': {},
      \ 'body': [],
      \}

function! goem#command#show_mail#init(buf_name, maildir_name, mail_key) abort
  let s:show_mail_cmd.bufnr = bufnr(a:buf_name)
  let s:show_mail_cmd.maildir_name = a:maildir_name
  let s:show_mail_cmd.mail_key = a:mail_key
  let l:mail = goem#api#fetch_mail(a:maildir_name, a:mail_key)
  let s:show_mail_cmd.mail = l:mail
  let s:show_mail_cmd.body = split(l:mail["body"], '\n')
  call s:show_mail_cmd._buffer_setting()
  call s:show_mail_cmd._key_mapping()
  return s:show_mail_cmd
endfunction

function! s:show_mail_cmd._buffer_setting() abort
  setlocal buftype=acwrite
  setlocal nonumber norelativenumber nowrap nomodified noswapfile
endfunction

function! s:show_mail_cmd._key_mapping() abort
endfunction

function! s:show_mail_cmd.render() abort
  call appendbufline(self.bufnr, '$', "Subject: "..self.mail["subject"])
  call appendbufline(self.bufnr, '$', "To: "..join(self.mail["headers"]["To"], ", "))
  call appendbufline(self.bufnr, '$', "From: "..join(self.mail["headers"]["From"], ", "))
  call appendbufline(self.bufnr, '$', "")
  call appendbufline(self.bufnr, '$', self.body)
  call deletebufline(self.bufnr, 1)
endfunction

function! s:_decode_mail_body(body) abort
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
