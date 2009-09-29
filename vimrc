" vim: sw=2 foldmethod=marker
set nocp
syntax on
filetype plugin on

set background=dark
colorscheme tango2

set tags=./tags,./TAGS,tags,TAGS,../tags,../../tags,../../../tags,../../../../tags
set viminfo=%,'50,\"100,:100,n~/.viminfo

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent

let g:git_diff_spawn_mode = 2
let g:netrw_list_hide = "\.pyc,\.swp,\.bak,\.git"
let g:netrw_special_syntax = 1
let g:netrw_liststyle = 1

let sessionoptions = "buffers,curdir,help,tabpages,winsize"

map <F7> :SessionList<CR>

" Taglist
map <F6> :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Process_File_Always = 1

" {{{ Autocommands
au FileType mail   set tw=70
" }}}

set t_Co=256                " number of colors

" {{{ For VIM 7
if version >= 700
  map <F12> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
  set spellfile=~/.vim/spellfile.add
  "  set spelllang=ca
  set sps=best,10
  " Setup omni-func for completion.
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType c set omnifunc=ccomplete#Complete
  autocmd FileType cpp set omnifunc=ccomplete#Complete
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType perl setlocal expandtab ts=4
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType sgml set omnifunc=xmlcomplete#CompleteTags
endif
" }}}

set printoptions=paper:a4,portrait:n

" {{{ Key mappings
" Buffer Explorer
map <C-e> :BufExplorer<cr>
map <f9> :BufExplorer<cr>
map <S-f9> :HSBufExplorer<cr>
map <C-f9> :VSBufExplorer<cr>
" FileExplorer
map <f8> :e %:p:h/<cr>
map <S-f8> :Sex %:p:h/<cr>
map <C-f8> :Vex %:p:h/<cr>

" Close windows
nmap <C-kDel> :quit<CR>
imap <C-kDel> <Esc>:quit<CR>
" }}}

set wildmenu
nnoremap ' `
nnoremap ` '
let mapleader = ","
set history=1000
set title
set scrolloff=3

let g:bufExplorerShowRelativePath=1 

" Statusline
set laststatus=2
set statusline=%f%m%r%h%w\ %l,%v\ [%p%%]\ [%{Tlist_Get_Tagname_By_Line()}]

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabRetainCompletionType = 0

let $PYTHONPATH .= expand("$HOME/.vim/ropevim/")
source $HOME/.vim/ropevim/ropevim.vim

" source local configuration file
if filereadable(expand("$HOME/.vimrc.local"))
   source $HOME/.vimrc.local
endif
