" LBufWin.vim:  Open a location list with buffers matching an optional pattern.
" Maintainer: Cory T. Echols (cory@sixtimesnine.org)
" 
" License: GPL
"
" Note:  This code is too long for a 'tip', but I don't feel it contains enough
" functionality to be a true 'plugin'.  If you maintain a plugin with similar
" functionality and wish to adopt this code for inclusion in your plugin, please
" contact me.
" 
" This plugin contains one command:
"
" :Ls <pattern>
"
" The command creates a location list containing all of the currently loaded
" buffers in vim.  It takes one (optional) argument.  If it is supplied, it is
" treated as a pattern, and only buffers matching that pattern will be
" displayed.
" 
" Location lists are a feature of Vim 7 and up.  Please see :he location-list if
" you are curious.

command! -nargs=* Ls :call <SID>LBufList(<q-args>)

function! s:LBufList(...)
   let pattern = '.'
   if(len(a:000) >= 1)
      let pattern = a:1
   endif
   let bufListTxt = s:Redir("buffers")
   let bufListLines = split(bufListTxt, '\n')
   let bufListLines = bufListLines[0:-1]
   let bufLocList = s:MakeBufLocList(bufListLines, pattern)
   call setloclist(0, bufLocList, ' ')
   lwindow
endfunction

"Capture long output of a comand into a variable.
function! s:Redir(cmd)
   let output = ""
   redir =>> output
   silent exe a:cmd
   redir END
   return output
endfunction

" Buffer List
function! s:MakeBufLocList(bufListLines, pattern)
   let locList = []
   for lineTxt in a:bufListLines
      let locItem = {}
      let lineTxt = substitute(lineTxt, '\v^\s*', '', ' ')
      let locItem["bufnr"] = str2nr(substitute(lineTxt, '\v^(\d+).*$', '\1', ' '))
      let lineTxt = substitute(lineTxt, '\v^[^"]*"', '', ' ')
      let locItem["lnum"] = str2nr(substitute(lineTxt, '\v^.*line\s*(\d+)\s*$', '\1', ' '))
      let locItem["text"] = substitute(lineTxt, '\v^(.*)"\s*line\s*\d+\s*$', '\1', ' ')
      if((locItem["text"] =~ a:pattern) && (buflisted(locItem["bufnr"])))
         call add(locList, locItem)
      endif
   endfor
   return locList
endfunction
