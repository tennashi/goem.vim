scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#goem#new()
let s:HTTP = s:V.import('Web.HTTP')
let s:JSON = s:V.import('Web.JSON')

function! goem#api#fetch_mail(maildir_name, mail_key) abort
  let l:res = s:HTTP.get("localhost:8888/maildir/"..a:maildir_name.."/"..a:mail_key)
  echom l:res["content"]
  return json_decode(l:res["content"])
endfunction

function! goem#api#fetch_mails(maildir_name) abort
  let l:res = s:HTTP.get("localhost:8888/maildir/"..a:maildir_name.."?sub_dir=cur")
  return json_decode(l:res["content"])
endfunction

function! goem#api#fetch_maildir() abort
  let l:res = s:HTTP.get("localhost:8888/maildir/")
  return json_decode(l:res["content"])
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
