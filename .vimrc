" automatically download vim-plug if not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Vim Plug
call plug#begin('~/.vim/plugged')

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" CtrlP
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }

" Color Schemes
Plug 'flazz/vim-colorschemes'

" NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" NERD Commenter
Plug 'scrooloose/nerdcommenter'
" vim-ripgrep
Plug 'jremmen/vim-ripgrep'
" Surround
Plug 'tpope/vim-surround'

" Syntastic
Plug 'vim-syntastic/syntastic'

call plug#end()

" Initialize plugin system
" call plug#end()

" Packages
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_custom_ignore = {
 \ 'dir': '\.git$\|\.yardoc\|bower_components|node_modules|public$|log\|tmp$',
 \ 'file': '\.so$\|\.dat$|\.DS_Store$'
 \ }
" Key Commands
map <C-\> :NERDTreeToggle<CR>
