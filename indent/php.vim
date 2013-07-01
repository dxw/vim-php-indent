" Vim indent file
" Language:		PHP
" Maintainer:		Tom Adams <tom@dxw.com>
" URL:			https://github.com/dxw/vim-php-indent
" Version:              1

"" Initialization

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nosmartindent

" Now, set up our indentation expression and keys that trigger it.
setlocal indentexpr=PhpIndent()
" setlocal indentkeys=0{,0},0),0],!^F,o,O,e,0.,0+,,
setlocal indentkeys=0{,0},0),0],0>,!^F,o,O,e,0.,0+,,

" Only define the function once.
if exists("*PhpIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


"" Actual indenting code

function PhpIndent()

  "" Variables

  let currentNum = v:lnum
  let previousNum = prevnonblank(currentNum - 1)

  " Strip whitespace
  let currentLine  = substitute(getline(currentNum),  '^\s*\(.\{-}\)\s*$', '\1', '')
  let previousLine = substitute(getline(previousNum), '^\s*\(.\{-}\)\s*$', '\1', '')

  let previousIndent = indent(previousNum)

  let left  = 0
  let right = 0


  "" Decisions

  if         currentLine =~ '^}'
        \ || currentLine =~ '^)'
        \ || currentLine =~ '^]'
        \ || currentLine =~ '^end\(if\|while\|for\|foreach\|switch\);$'
        \ || currentLine =~ '^<?php\s\+end\(if\|while\|for\|foreach\|switch\);\?\s*?>$'
        \ || currentLine =~ '^<\/\w\+>$'
    let left = 1
  endif

  if         previousLine =~ '{$'
        \ || previousLine =~ '($'
        \ || previousLine =~ '[$'
        \ || previousLine =~ '^\(if\|while\|for\|foreach\|switch\).*:$'
        \ || previousLine =~ '^<?php\s\+\(if\|while\|for\|foreach\|switch\).*:\s*?>$'
    let right = 1
  endif

  let openTagMatch = matchlist(previousLine, '^<\(\w\+\)\(\s.*\)\?>$')
  if len(openTagMatch) > 0
    if index([ 'base', 'link', 'meta', 'hr', 'br', 'wbr', 'img', 'embed', 'param', 'source', 'track', 'area', 'col', 'input', 'keygen', 'menuitem' ], openTagMatch[1]) ==# -1
      " line begins with an opening tag
      let right = 1
      if previousLine =~ '<\/\w\+>$'
        " line ends with a closing tag
        " i.e. catch <div></div>
        let right = 0
      endif
    endif
  endif

  if currentNum ==# 1
    return 0
  elseif left && !right
    return previousIndent - &shiftwidth
  elseif right && !left
    return previousIndent + &shiftwidth
  else
    return previousIndent
  endif
endfunction
