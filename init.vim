let g:ale_disable_lsp = 1
call plug#begin("~/.vim/plugged")
"Plugins

" Appearance
Plug 'dracula/vim'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'lukas-reineke/indent-blankline.nvim'

" File Navigation
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Editing Enhancements
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'turbio/bracey.vim'
Plug 'tommcdo/vim-exchange'
Plug 'dense-analysis/ale'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'

Plug '907th/vim-auto-save'
"
" Language Support
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lervag/vimtex'

" Start-Up
Plug 'mhinz/vim-startify'

" Git Integration
Plug 'airblade/vim-gitgutter'

" Debugger (Commented Out)
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
"
call plug#end()

"config

set conceallevel=0
set nocompatible
set number
set relativenumber 
set encoding=utf8
set nowrap
set autoindent
filetype plugin indent on
syntax enable
set termguicolors
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=auto
set ignorecase
" open new split panes to right and below
set splitright
set splitbelow
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THEME/APPEARANCE
" endif
colorscheme dracula

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

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
lua require('treesitter')
lua require('indent_blankline')
lua require('dap_config')
lua require("dap-python").setup("python3")


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FILE NAVIGATION
"Use enter to open a new line below, and Shift Enter for new line NOT in insert mode
let g:NERDTreeShowHidden = 0
let g:NERDTreeMinimalUI = 1
" let g:NERDTreeIgnore = [] let g:NERDTreeStatusline = '' let g:NERDTreeNotificationThreshold = 500
let g:NERDTreeChDirMode = 2
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

"Go to home direct. with Home
command Home NERDTree ~
command Base NERDTree $PWD

let g:NERDTreeIgnore = ['^node_modules$']

"Search Shit
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit'
			\}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING ENHANCEMENTS
let g:bracey_server_allow_remote_connections=1
let g:bracey_server_port=1111

nmap cx <Plug>(Exchange)
xmap X <Plug>(Exchange)
nmap cxc <Plug>(ExchangeClear)
nmap cxx <Plug>(ExchangeLine)

au BufReadPost,BufNewFile *.py,*.pyc,*.js SemanticHighlight
let g:ale_linters = {'python': ['pylint', 'flake8', 'mypy','pyright']}
let g:ale_echo_msg_format='[%linter%] [%severity%] %code% %s'
let g:ale_python_pylint_options = '--rcfile ~/.config/.pylintrc'
let g:ale_virtualenv_dir_names = []
let g:ale_fixers = {'python':['add_blank_lines_for_python_control_statements', 'autoimport', 'autopep8', 'isort', 'remove_trailing_lines', 'trim_whitespace']}
let g:ale_fix_on_save = 1

"this shit does not work on kotlin 120% cpu usage
let g:ale_pattern_options = {
\   '.*\.kt$': {'ale_enabled': 0},
\}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LANGUAGE SUPPORT

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

hi Pmenu guibg=Green

" Latex support
let g:auto_save = 0
let g:vimtex_view_method = 'zathura'
"let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"

augroup latexFile
    autocmd!
    autocmd FileType tex execute 'set wrap'
    autocmd FileType tex execute 'VimtexCompile'
    autocmd FileType tex execute 'nmap <localleader>v <plug>(vimtex-view)'
    au FileType tex let b:auto_save_events = ["InsertLeave", "TextChangedI", "TextChanged", "CursorHoldI"]
    au FileType tex let b:auto_save = 1
augroup END

let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction
map <leader>l :call ToggleWrap()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" START-UP

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL REMAPS
nmap <CR> o <BS>
"Make the arrow keys resize current window
nmap <Up> :res +5 <CR>
nmap <Down> :res-5<CR>
nmap <Left> :vertical resize -5<CR>
nmap <Right> :vertical resize +5<CR>
"NerdTree shit

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
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
	split term://fish
	resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" Debugger stuff
" Start Debugging
nnoremap <c-d> :lua require('dap').set_exception_breakpoints({ "all" }) <CR>
nnoremap <c-d> :DapNew <CR>
nnoremap <c-d> :lua require("dapui").setup() require('dapui').open() <CR>
" nnoremap <c-d> :lua require('dapui').open() <CR>

" Toggle Breakpoint
nnoremap <c-d>b :DapToggleBreakpoint <CR>

" Run to cursor
nnoremap <c-d>c :lua require('dap').run_to_cursor() <CR>

" Restart 
nnoremap <c-d>r :lua require('dap').restart() <CR>

" Continue Debugging
nnoremap <F5> :DapContinue <CR>

" Step Into
nnoremap <F10> :DapStepInto <CR>

" Step Over
nnoremap <F9> :DapStepOver <CR>

" Step Out
nnoremap <S-F10> :DapStepOut <CR>

" Terminate Debugging
nnoremap <c-d>q :DapTerminate <CR>
nnoremap <c-d>q :lua require('dapui').close() <CR>

" List Breakpoints
nnoremap <S-F5> :lua require('dap').list_breakpoints() <CR>

" Set Exception Breakpoints
