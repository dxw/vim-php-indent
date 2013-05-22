" Vim indent file
" Language:		PHP
" Maintainer:		Tom Adams <tom@dxw.com>
" URL:			https://github.com/dxw/php-indent
" Version:              0.1
" Last Change:          2013-05-22

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

  let currentLine  = substitute(getline(currentNum),  '^\s*\(.\{-}\)\s*$', '\1', '')
  let previousLine = substitute(getline(previousNum), '^\s*\(.\{-}\)\s*$', '\1', '')

  let previousIndent = indent(previousNum)


  "" Decisions

  if currentNum ==# 1
    return 0
  end

  if         currentLine =~ '^}'
        \ || currentLine =~ '^)'
        \ || currentLine =~ '^]'
        \ || currentLine =~ '^(<\?php\s*)?end(if|while|for|foreach|switch)(\s*\?>)?$'
        \ || currentLine =~ '^<\/\w+>$'
    return previousIndent - &shiftwidth
  endif

  if         previousLine =~ '{$'
        \ || previousLine =~ '($'
        \ || previousLine =~ '[$'
        \ || previousLine =~ '^(<\?php\s*)?(if|while|for|foreach|switch).*:(\s*\?>)?$'
    return previousIndent + &shiftwidth
  endif

  return previousIndent
endfunction