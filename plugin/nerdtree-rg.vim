if exists('g:nerdtree_rg')
    finish
endif
let g:nerdtree_rg = 1

function! NERDTreeRg()
  let dirnode = g:NERDTreeDirNode.GetSelected()
  echo dirnode.path.str()

  let pattern = input('Enter the search pattern: ')
  if pattern ==# ''
      echo 'Aborted'
      return
  endif


  call fzf#vim#grep(
        \ 'rg --hidden --follow --glob "!.git/*" --column --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case "' . pattern . '" ' . dirnode.path.str(),
        \  1,
        \ fzf#vim#with_preview('right:40%', '?')
        \ )
endfunction

call NERDTreeAddMenuItem({
      \ 'text': '(g)rep directory',
      \ 'shortcut': 'g',
      \ 'callback': 'NERDTreeRg',
      \ })
