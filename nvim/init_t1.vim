" Vertical line delineating column-limit
:set colorcolumn=100
:hi ColorColumn ctermbg=lightcyan guibg=blue
" Highlight characters that are over the column-limit
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

:set autochdir
:set rnu
:set autoindent
:set hlsearch
:set incsearch
:set smartcase
:set laststatus=2

" Keybindings

let mapleader = " "

nnoremap \ <C-w>
noremap <Leader>s :update<CR>
noremap <leader>: :!
nnoremap <Leader>io o<Esc>k
nnoremap <Leader>iO O<Esc>j
tnoremap <C-n> <C-\><C-n>

" Copy/paste shortcuts
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" Line movement
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" Enable easy tab-switching in terminal mode
tnoremap \ <C-w>
tnoremap <C-w>w <C-\><C-n><C-w>w
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

map <silent> <Leader>\ oimport pdb; pdb.set_trace()<esc>
" map <silent> <Leader> Oimport pdb; pdb.set_trace()<esc>
" PLUGIN: Sneak 
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
:noremap <Leader> <C-w>

set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:auto_save = 0  " enable AutoSave on Vim startup
let g:auto_save_update_time = 1000

" Auto-commands
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
      \ && b:NERDTree.isTabTree()) | q | endif

" Start NERDTree
autocmd VimEnter * NERDTree
" Go to previous (last accessed) window.
autocmd VimEnter * wincmd p
let g:NERDTreeChDirMode = 2
nnoremap <leader>N :NERDTree .<CR>

" UltiSnips settings
let g:UltiSnipsExpandTrigger='<c-tab>'

" ======================================
" Lightline (status bar) configuration
" ======================================
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             ['gitbranch', 'readonly', 'modified', 'relativepath'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }
let g:lightline.component = {
    \ 'lineinfo': '%3l/%L  col %-2v',
    \ 'percent': '',
    \ }
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
let g:mkdp_ope_to_the_world = 0

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

" ===================================
" Plugins
" ===================================
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Semantic highlighting for Python "
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python' }

Plug 'justinmk/vim-sneak'

Plug 'tpope/vim-fugitive'

Plug 'preservim/nerdtree'

"Plug 'davidhalter/jedi-vim'

Plug 'sheerun/vim-polyglot'

Plug 'majutsushi/tagbar'

Plug 'vim-scripts/vim-auto-save'

Plug 'universal-ctags/ctags'

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'tpope/vim-surround'

Plug 'airblade/vim-rooter'

Plug 'psf/black', { 'branch': 'stable' }

Plug 'camspiers/animate.vim'

Plug 'camspiers/lens.vim'

Plug 'colmbus72/slim'

Plug 'itchyny/lightline.vim' 
Plug 'mhinz/vim-signify'

Plug 'tpope/vim-commentary'

Plug 'junegunn/goyo.vim'

Plug 'junegunn/limelight.vim'

" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

"Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
"
"" " Use completion-nvim in every buffer
"autocmd BufEnter * lua require'completion'.on_attach()
"" " Use <Tab> and <S-Tab> to navigate through popup menu
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
"" " Set completeopt to have a better completion experience
"set completeopt=menuone,noinsert,noselect
"
"" " Avoid showing message extra message when using completion
"set shortmess+=c
"nmap <tab> <Plug>(completion_smart_tab)
"nmap <s-tab> <Plug>(completion_smart_s_tab)
"" Specify a directory for plugins
"" " - For Neovim: stdpath('data') . '/plugged'
"
"Plug 'neovim/nvim-lspconfig'
"
"Plug 'nvim-lua/diagnostic-nvim'

Plug 'dense-analysis/ale'

call plug#end()

" lua require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach}

