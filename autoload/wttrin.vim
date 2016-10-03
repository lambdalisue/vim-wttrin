" Vim front end for weather web application wttr.in.
" Version: 0.1.0
" Author:  ryunix <ryunix.net@gmail.com>
" License: MIT License

let s:save_cpoptions = &cpoptions
set cpoptions&vim

let s:V = vital#wttrin#new()
let s:OptionParser = s:V.import('OptionParser')

let s:parser = s:OptionParser.new()

call s:parser.on('--location=VALUE', '')

function! wttrin#complete(arglead, cmdline, cursorpos) abort
  return s:parser.complete_greedily(a:arglead, a:cmdline, a:cursorpos)
endfunction

function! wttrin#main(q_args) abort
  let l:parsed_args = s:parse_args(a:q_args)
endfunction

function! s:parse_args(q_args) abort
  return s:parser.parse(a:q_args)
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
