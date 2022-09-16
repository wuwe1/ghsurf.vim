if exists("g:loaed_ghsurf_plugin")
  finish
endif
let g:loaded_ghsurf_plugin = 1

command! -nargs=* GHEdit call ghsurf#edit("<mods>", <q-args>)

