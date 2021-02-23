let g:ale_disable_lsp = 1
call plug#begin("~/.vim/plugged")
"Plugins

Plug 'dracula/vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs' 
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tommcdo/vim-exchange'
Plug 'mattn/emmet-vim'
Plug 'turbio/bracey.vim'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-obsession'
Plug 'dense-analysis/ale'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'tpope/vim-eunuch'
Plug 'airblade/vim-gitgutter'
Plug '907th/vim-auto-save'
call plug#end()
"config

set conceallevel=0
set nocompatible
set number
set relativenumber 
set encoding=utf8
set nowrap
set autoindent
"FOnt/Theme
if (has("termguicolors"))
	set termguicolors
endif
colorscheme dracula

"Use enter to open a new line below, and Shift Enter for new line NOT in insert mode
nmap <CR> o <BS>

"Make the arrow keys resize current window
nmap <Up> :res +5 <CR>
nmap <Down> :res-5<CR>
nmap <Left> :vertical resize -5<CR>
nmap <Right> :vertical resize +5<CR>
"NerdTree shit
let g:NERDTreeShowHidden = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeNotificationThreshold = 500
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

"Go to home direct. with Home
command Home NERDTree /home/oscar 

"load saved session from home screen
command Sess :source Session.vim | :exe 'normal '

"Save with admin perms
command Susave :w !sudo tee %<CR>
" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"terminal

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
	split term://bash
	resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" Startify shit

let g:startify_custom_header_quotes = [
			\ ["Well well well, look who's back to get ass fucked by technology again!"],
			\ ["I use arch btw."],
			\ ['You fucking worthless braindead scumfuck bastard pile of trash mental dickface that should be gunned down in the street like the degenerate you are.'],
			\ ['Thomas Had Never Seen Such Bullshit Code Before'],
			\ ['He’s making a database.', 'He’s sorting it twice.', 'SELECT * from contacts WHERE', 'behavior = nice', 'SQL Clause is coming to town!'],
			\ ['No one has asked this question on Stack Overflow yet.', '' , 'I am so fucked'],
			\ ['Errors are red', 'My screen is blue', 'Someone please help me', 'I just deleted sys32'],
			\ {-> systemlist('')}
			\]

let g:startify_custom_footer =startify#center(['', '*bashes head repeatedly against keyboard*'])

let g:startify_custom_header =
			\ 'startify#center(startify#fortune#cowsay())'

let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}]
nnoremap <c-h> :Startify<CR>
"Search Shit
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit'
			\}
"COC config lmao
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'cocstatus': 'coc#status'
			\ },
			\ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

nmap cx <Plug>(Exchange)
xmap X <Plug>(Exchange)
nmap cxc <Plug>(ExchangeClear)
nmap cxx <Plug>(ExchangeLine)
"Emmet

"Braceys
let g:bracey_server_allow_remote_connections=1
let g:bracey_server_port=1111
let g:NERDTreeIgnore = ['^node_modules$']
let g:indentLine_fileTypeExclude = ['json']

"COC
hi Pmenu guibg=Green
"python syntax
au BufReadPost,BufNewFile *.py,*.pyc,*.js SemanticHighlight
let g:ale_linters = {'python': ['pylint', 'flake8', 'mypy','pyright']}
let g:ale_echo_msg_format='[%linter%] [%severity%] %code% %s'
let g:ale_python_pylint_options = '--rcfile ~/.config/.pylintrc'
let g:ale_virtualenv_dir_names = []
let g:ale_fixers = {'python':['add_blank_lines_for_python_control_statements', 'autoimport', 'autopep8', 'isort', 'remove_trailing_lines', 'trim_whitespace']}
let g:ale_fix_on_save = 1

"Auto save
let g:auto_save_write_all_buffers = 1
let g:auto_save = 1
" au BufReadPost,BufNewFile *.js,*.css,*.scss let b:auto_save = 1
