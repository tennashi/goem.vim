scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#goem#new()
let s:URI = s:V.import('Web.URI')

function! goem#list_maildir() abort
  execute 'split' 'goem://list/maildir'
endfunction

function! goem#list_mail(dir_name) abort
  execute 'vsplit' '`="goem://list/mail/"..a:dir_name`'
endfunction

function! goem#show_mail(dir_name, key) abort
  execute 'vsplit' '`="goem://show/mail/"..a:dir_name.."/"..a:key`'
endfunction

function! goem#render(buf_name) abort
  let l:cmd = s:parse_cmd(a:buf_name)
  call l:cmd.render()
endfunction

function! s:parse_cmd(uri_str) abort
  let l:cmd = s:parse_cmd_uri(a:uri_str)
  if l:cmd.name ==# 'list'
    if l:cmd.resource ==# 'maildir'
      return goem#command#list_maildir#init(a:uri_str)
    elseif l:cmd.resource ==# 'mail'
      return goem#command#list_mail#init(a:uri_str, l:cmd.args[0])
    endif
  elseif l:cmd.name ==# 'show'
    if l:cmd.resource ==# 'mail'
      return goem#command#show_mail#init(a:uri_str, l:cmd.args[0], l:cmd.args[1])
    endif
  endif
endfunction

function! s:parse_cmd_uri(uri_str) abort
  let l:uri = s:URI.new(a:uri_str)
  let l:args = split(l:uri.path(), '/')
  return { 'name': l:uri.host(), 'resource': get(l:args, 0), 'args': l:args[1:] }
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
