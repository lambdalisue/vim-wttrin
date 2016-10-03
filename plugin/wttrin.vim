" Vim front end for weather web application wttr.in.
" Version: 0.1.0
" Author:  ryunix <ryunix.net@gmail.com>
" License: MIT License

if exists('g:loaded_wttrin')
  finish
endif
let g:loaded_wttrin = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
