scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#goem#new()
let s:HTTP = s:V.import('Web.HTTP')

function! goem#api#fetch_mail(maildir_name) abort
  let l:res = s:HTTP.get("localhost:8888/maildir/"..a:maildir_name.."/cur")
  return json_decode(l:res["content"])
endfunction

function! goem#api#fetch_maildir() abort
  let l:res = s:HTTP.get("localhost:8888/maildir/")
  return json_decode(l:res["content"])
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
