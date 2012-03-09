" Vim folding file
" Language:	Python
" Author:	newkedison
" copy PythonFoldText from http://www.vim.org/scripts/script.php?script_id=515
" Last Change:	2012.3.9
" Version:	0.1

let s:in_quote = 0
let s:nest_level = {}

function! IndentToNest(indent)
  if empty(s:nest_level)
    let s:nest_level = {(a:indent): 1}
    return 1
  endif
  if has_key(s:nest_level, a:indent)
    return s:nest_level[a:indent]
  else
    let min_key = 999
    let max_key = -1
    for key in keys(s:nest_level)
      if key > a:indent && key < min_key
        let min_key = key
      endif
      if key > max_key
        let max_key = key
      endif
    endfor
    if min_key != 999
      return s:nest_level[min_key]
    endif
    call extend(s:nest_level, {(a:indent): (s:nest_level[max_key] + 1)})
    return s:nest_level[max_key] + 1
  endif
endfunction

function! PythonFoldExpr(lnum)
  let line = getline(a:lnum)
  let indent = indent(a:lnum)
  let triple_quote = '\("""\|''''''\)'
  let ret = "="

  if line =~ '{{{\|[[['
    let ret = "a1"
  elseif line =~ '}}}\|]]]'
    let ret = "s1"
  elseif line =~ '^\s*#'
    let ret = "="
  elseif s:in_quote != 0
    if line =~ triple_quote
      let s:in_quote = 0
      let ret = "s1"
    else
      let ret = "="
    endif
  elseif line =~ '^\s*\(class\|def\)\s'
    let ret = ">" . IndentToNest(indent)
  elseif line =~ 'if\s\+__name__\s\+==\s\+[''\"]__main__[''\"]\s*:'
    let ret = ">1"
  elseif line =~ triple_quote && line !~ triple_quote . '.*' . triple_quote
    if s:in_quote == 0
      let s:in_quote = 1
      let ret = "a1"
    else
      let s:in_quote = 0
      let ret = "s1"
    endif
  endif
  if nextnonblank(a:lnum + 1) == 0
    let s:in_quote = 0
    let s:nest_level = {}
  endif
  return ret
endfunction

function! PythonFoldText()
  let line = getline(v:foldstart)
  let nnum = nextnonblank(v:foldstart + 1)
  let nextline = getline(nnum)
  if nextline =~ '^\s\+"""$'
    let line = line . getline(nnum + 1)
  elseif nextline =~ '^\s\+"""'
    let line = line . ' ' . matchstr(nextline, '"""\zs.\{-}\ze\("""\)\?$')
  elseif nextline =~ '^\s\+"[^"]\+"$'
    let line = line . ' ' . matchstr(nextline, '"\zs.*\ze"')
  elseif nextline =~ '^\s\+pass\s*$'
    let line = line . ' pass'
  endif
  let size = 1 + v:foldend - v:foldstart
  if size < 10
    let size = " " . size
  endif
  if size < 100
    let size = " " . size
  endif
  if size < 1000
    let size = " " . size
  endif
  return size . " lines: " . line
endfunction

setlocal foldmethod=expr
setlocal foldexpr=PythonFoldExpr(v:lnum)
setlocal foldtext=PythonFoldText()
