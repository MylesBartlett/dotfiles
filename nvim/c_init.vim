" ===================================
" Plugins
" ===================================
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

Plug 'airblade/vim-rooter'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'janko-m/vim-test'

" Semantic highlighting for Python "
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python' }

" ----------- Git -----------
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'rhysd/git-messenger.vim'  " popup commit message for cursor (:GitMessenger)
Plug 'tpope/vim-rhubarb'  " GitHub support for fugitive

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/nerdtree'

" ---------- Python ----------
Plug 'sheerun/vim-polyglot'
Plug 'raimon49/requirements.txt.vim'  " syntax highlighting for requirements.txt
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'psf/black', { 'branch': 'stable' }

" ---------Status bar --------
Plug 'itchyny/lightline.vim' 

" --------- Editing ---------
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'farmergreg/vim-lastplace'  " remember cursor position
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'  " line stuff up with ga motion
Plug 'tpope/vim-repeat'  " repeat supported plugin maps
Plug 'junegunn/vim-easy-align'  " line stuff up with ga motion
Plug 'jiangmiao/auto-pairs'  " insert closing quotes, parens, etc

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'morhetz/gruvbox'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'dense-analysis/ale'

call plug#end()

" Colorscheme
set termguicolors     " enable true colors support
colorscheme gruvbox

" General Settings
set relativenumber
set autochdir
set history=1000  " remember more commands and search history
set undolevels=10000  " maximum number of changes that can be undone
set undoreload=100000  " maximum number lines to save for undo on a buffer reload
set splitright  " prefer splitting right and below
set splitbelow

" Highlighting in cursor line
set cursorline

" Automatic indentation
set autoindent

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set smartcase

set laststatus=2
set mouse=a  " change cursor per mode
set wrapscan  " begin search from top of file when nothing is found anymore
set noerrorbells  " remove bells (I think this is default in neovim)
set visualbell

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Vertical line delineating column-limit
set colorcolumn=100
hi ColorColumn ctermbg=lightcyan guibg=blue
" Highlight characters that are over the column-limit
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

" Keybindings
let mapleader = " "
nnoremap <Leader><Leader> zz
nnoremap U <C-R> 
nnoremap <Leader>0 :source ~/.config/nvim/init.vim <Enter>
nnoremap <Leader>, :nohlsearch<cr>
"replaces the word under cursor for whatever you want; after that, you can keep pressing  . and
"it will keep substituting all the instances of the original word (ala multiple cursors). You can 
"skip them with n (as you would in a normal search). The second mapping goes the other way around:
"substitutes upwards.
nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

noremap <Leader>s :update<CR>
noremap <leader>: :!
nnoremap <Leader>io o<Esc>k
nnoremap <Leader>iO O<Esc>j

" Copy/paste shortcuts
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" Line movement
nnoremap <Leader>m :m+
nnoremap <Leader>M :m-

" Enable easy tab-switching
tnoremap <C-w>w <C-\><C-n><C-w>w
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-n> <C-\><C-n>

" Make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

"  Resizing spilt windows
noremap <silent> <C-H> :vertical resize +1<CR>
noremap <silent> <C-L> :vertical resize -1<CR>
noremap <silent> <C-J> :resize +1<CR>
noremap <silent> <C-K> :resize -1<CR>

" Commenting with Commentary
nmap \ <Plug>Commentary
xmap \ <Plug>Commentary
omap \ <Plug>Commentary
" ===========
" Spellcheck
" ===========
augroup markdownSpell
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md setlocal spell
augroup END


" ==============
" PLUGIN: Sneak 
" ==============
map f <Plug>Sneak_f
map F <Plug>Sneak_F

" PLUGIN: FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Auto-commands
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
      \ && b:NERDTree.isTabTree()) | q | endif

" Start NERDTree
autocmd VimEnter * NERDTree
" Go to previous (last accessed) window.
autocmd VimEnter * wincmd p
let g:NERDTreeChDirMode = 2
nnoremap <leader>N :NERDTree .<CR>

" ======================================
" Lightline (status bar) configuration
" ======================================
set noshowmode

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'selenized_black',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'gitbranch', 'readonly', 'modified', 'relativepath'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }
let g:lightline.component = {
    \ 'lineinfo': '%3l/%L  col %-2v',
    \ 'percent': '',
    \ }

command! Slack :call slim#StartSlack()
			
" ==================
" Goyo configuration
" ==================
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" ==============================
" markdown-preview configuration
" ==============================

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" --- vim-signify ---
if &runtimepath =~? 'vim-signify'
  set signcolumn=yes
  let g:signify_priority = 0

  let g:signify_sign_add = ''
  let g:signify_sign_delete = ''
  let g:signify_sign_delete_first_line = ''
  let g:signify_sign_change = ''

  " let g:signify_sign_change = '~'
  highlight! link SignifySignChange GruvboxBlueSign

  " nifty hunk motions
  omap ic <plug>(signify-motion-inner-pending)
  xmap ic <plug>(signify-motion-inner-visual)
  omap ac <plug>(signify-motion-outer-pending)
  xmap ac <plug>(signify-motion-outer-visual)
endif


"*****************************************************************************
"" Ale
"*****************************************************************************
let g:ale_fix_on_save = 1
let g:ale_linters = {'python': ['mypy', 'pylint', 'flake8', 'pydocstyle']}
let g:ale_fixers = {'python': ['black', 'isort', 'trim_whitespace', 'remove_trailing_lines']}
let g:ale_linters_explicit = 1
let g:ale_disable_lsp = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '> '
"*****************************************************************************
"" LSP
"*****************************************************************************

" ====================
" General LSP settings
" ====================
lua require'nvim_lsp'.pyls_ms.setup{}

autocmd BufEnter * lua require'completion'.on_attach()
autocmd BufEnter * lua require'diagnostic'.on_attach()

" Mappings
nnoremap <silen1t> <Leader>d	<cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K		<cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>D	<cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k>		<cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD		<cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr		<cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>r	<cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>o	<cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <Leader>O	<cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" ===================
" Completion settings
" ===================
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"map <c-p> to manually trigger completion
imap <silent> <c-p> <Plug>(completion_trigger)

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'vim-snip'
let g:completion_enable_auto_signature = 0  " crazy slow
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c


" ====================
" Diagnostics settings
" ====================
let g:diagnostic_insert_delay = 1
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = v:null
let g:diagnostic_enable_underline = 1
