"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a 				" Enable mouse
set tabstop=4 				" 
set shiftwidth=4 			" 
set listchars=tab:\¦\ 		" Tab charactor 
set list
set foldmethod=indent 		" 
set foldlevelstart=99 		"  
set number 					" Show line number
set ignorecase 				" Enable case-sensitive 

" Disable backup
set nobackup
set nowb
set noswapfile

syntax on
set termguicolors

" Enable copying from vim to clipboard
if has('win32')
	set clipboard=unnamed  
else
	set clipboard=unnamedplus
endif

" Auto reload content changed outside
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime 
		\ | endif
autocmd FileChangedShellPost *
		\ echohl WarningMsg 
		\ | echo "File changed on disk. Buffer reloaded."
		\ | echohl None


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Resize pane
nmap <M-Right> :vertical resize +1<CR> 		
nmap <M-Left> :vertical resize -1<CR>
nmap <M-Down> :resize +1<CR>
nmap <M-Up> :resize -1<CR>

" Search a hightlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin list
" (used for Vim-plug - https://github.com/junegunn/vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('config').'/plugged')
" Theme
	Plug 'joshdick/onedark.vim', 					" Dark theme
	Plug 'overcache/NeoSolarized'

" File browser
	Plug 'preservim/nerdTree' 						" File browser  
	Plug 'Xuyuanp/nerdtree-git-plugin' 				" Git status
	Plug 'ryanoasis/vim-devicons' 					" Icon
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'unkiwii/vim-nerdtree-sync' 				" Sync current file 

" File search
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf'

" Status bar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

" Terminal
	Plug 'voldikss/vim-floaterm' 					" Float terminal
	" post install (yarn install | npm install) then load plugin only for editing supported files
	Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
" Code intellisense
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language server 
	Plug 'jiangmiao/auto-pairs' 					" Parenthesis auto 
	Plug 'alvan/vim-closetag'
	Plug 'mattn/emmet-vim' 
	Plug 'preservim/nerdcommenter' 					" Comment code 
	Plug 'liuchengxu/vista.vim' 					" Function tag bar 
	Plug 'alvan/vim-closetag' 						" Auto close HTML/XML tag 
	Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
" Code syntax highlight
	Plug 'yuezk/vim-js' 							" Javascript
	Plug 'MaxMEllon/vim-jsx-pretty' 				" JSX/React
	Plug 'jackguo380/vim-lsp-cxx-highlight'			" C++ syntax
	Plug 'uiiaoo/java-syntax.vim' 					" Java
" Debugging
	Plug 'puremourning/vimspector' 					" Vimspector

" Source code version control 
	Plug 'tpope/vim-fugitive' 						" Git
	Plug 'tpope/vim-eunuch'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set theme 
colorscheme onedark 

" Overwrite some color highlight 
if (has("autocmd"))
	augroup colorextend
		autocmd ColorScheme 
			\ * call onedark#extend_highlight("Comment",{"fg": {"gui": "#728083"}})
		autocmd ColorScheme 
			\ * call onedark#extend_highlight("LineNr", {"fg": {"gui": "#728083"}})
	augroup END
endif

" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Other setting
for setting_file in split(glob(stdpath('config').'/settings/*.vim'))
	execute 'source' setting_file
endfor

