if exists("g:loaded_ghsurf")
  finish
endif
let g:loaed_ghsurf = 1

let s:cpo_save = &cpo
set cpo&vim

function! s:gh_url_to_rawcontent_url(url)
  let [_, l:main, _, l:fragment; __] = matchlist(a:url, '^\([^#?]*\)\(?[^#]*\)\=\(#.*\)\=')
  if l:main =~? 'https\?://raw.githubusercontent.com'
    let l:url = l:main
  elseif l:main =~ '\vhttps?:\/\/(www\.)?github\.com'
    let l:url = substitute(l:main, 'github.com', 'raw.githubusercontent.com', "")
  else
    let l:url = ''
    echoerr 'Not a valid url: '.a:url
  endif
  let l:url = substitute(l:url, '\vblob\/([0-9a-fA-F]{40})', '\=submatch(1)', '')
  return [l:url, l:fragment]
endfunction

function! s:Mods(mods, ...) abort
  let l:mods = substitute(a:mods, '\C<mods>', '', '')
  let l:mods = l:mods =~# '\S$' ? l:mods . ' ' : l:mods
  return substitute(l:mods, '\s\+', ' ', 'g')
endfunction

function! ghsurf#edit(mods, url)
  let [l:url, l:fragment] = s:gh_url_to_rawcontent_url(a:url)
  exe 'edit '. l:url
  if !empty(l:fragment) && l:fragment =~? '#L\d\+'
    exe substitute(l:fragment, '\v#L(\d+)', '\=submatch(1)', '')
  endif
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
