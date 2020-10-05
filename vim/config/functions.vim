" Source local files if they exist
function! SourceLocalFile(path)
  let file=expand(a:path)
  if filereadable(file)
    execute 'source' file
  endif
endfunction
