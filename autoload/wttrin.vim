" Vim front end for weather web application wttr.in.
" Version: 0.1.0
" Author:  ryunix <ryunix.net@gmail.com>
" License: MIT License

let s:save_cpoptions = &cpoptions
set cpoptions&vim

let s:V = vital#wttrin#new()
let s:OptionParser = s:V.import('OptionParser')
let s:HTTP = s:V.import('Web.HTTP')

if !exists('g:wttrin#default_location')
  let g:wttrin#default_location = ''
endif

let s:parser = s:OptionParser.new()

call s:parser.on('--location=VALUE', '')

function! wttrin#complete(arglead, cmdline, cursorpos) abort
  return s:parser.complete_greedily(a:arglead, a:cmdline, a:cursorpos)
endfunction

function! wttrin#main(q_args) abort
  let l:parsed_args = s:parse_args(a:q_args)
  let l:location = s:get_location(l:parsed_args)
  let l:content = s:send_request(l:location)
endfunction

function! s:parse_args(q_args) abort
  return s:parser.parse(a:q_args)
endfunction

function! s:get_location(parsed_args) abort
  if has_key(a:parsed_args, 'location')
    return a:parsed_args['location']
  else
    return g:wttrin#default_location
  endif
endfunction

function! s:send_request(location) abort
  let l:settings = {
        \   'url' : 'http://wttr.in/' . a:location,
        \   'client' : [
        \     'curl',
        \     'wget',
        \   ],
        \ }

  let l:response = s:HTTP.request(l:settings)

  return l:response['content']
endfunction

function! s:remove_ansi_sequences(text) abort
  return substitute(a:text, '\e\[\%(\%(\d\+;\)*\d\+\)\?[mK]', '', 'g')
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
