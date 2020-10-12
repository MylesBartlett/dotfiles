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
Plug 'janko-m/vim-test'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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
" Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast, powerful configuration.
Plug 'luochen1990/rainbow'

" --------- Writing ---------
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Color scheme
Plug 'lifepillar/vim-gruvbox8'

" LSP
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-highlight', 
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc-prettier', 
Plug 'neoclide/coc-lists',

call plug#end()

" Appearance
set termguicolors     " enable true colors support
" lifepillar/vim-gruvbox8
set background=dark
colorscheme gruvbox8
let g:gruvbox_italic = 1

" General Settings
set relativenumber
set autochdir
set history=1000  " remember more commands and search history
set undolevels=10000  " maximum number of changes that can be undone
set undoreload=100000  " maximum number lines to save for undo on a buffer reload
set splitright  " prefer splitting right and below
set splitbelow

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

" Highlighting in cursor line
set cursorline
" hi CursorLine guibg=#666666
" Vertical line delineating column-limit
set colorcolumn=101
hi ColorColumn ctermbg=lightcyan guibg=#cc241d
" Highlight characters that are over the column-limit
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

" Keybindings
let mapleader = " "
nnoremap <Leader><Leader> zz
nnoremap U <C-R> 
nnoremap <Leader>0 :source ~/.config/nvim/init.vim <Enter>
nnoremap <Leader>, :nohlsearch<cr>
"
"Replaces the word under cursor for whatever you want; after that, you can keep pressing  . and
"it will keep substituting all the instances of the original word (ala multiple cursors). You can 
"skip them with n (as you would in a normal search). The second mapping goes the other way around:
"substitutes upwards.
nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

noremap <Leader>s :update<CR>
noremap <leader>: :!

" Copy/paste shortcuts
nnoremap Y y$
nmap cy "+y
nmap cd "+d

xmap gy "+y
xmap gd "+d

nnoremap <silent> cp  "+p
nnoremap <silent> cP  "+P
nnoremap <silent> cgp "+gp
nnoremap <silent> cgP "+gP

" Save and Quit buffer
nnoremap <silent> <Leader>x :x<CR>
vmap              <Leader>x <Esc><Leader>x

" Line movement
nnoremap <Leader>m :m+
nnoremap <Leader>M :m-1-

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

" =============
" CoC settings
" =============
" TextEdit might fail if hidden is not set.
set hidden
let g:coc_snippet_next = '<tab>'
nmap <silent> <M-CR> <Plug>(coc-fix-current)
autocmd BufWritePre *.py :CocCommand python.sortImports

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use tab to trigger completion and close the completion menu, relying on
" fuzzy matching opposed to menu cycling with <Tab>/<S-Tab>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ?
      \"\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <Leader>d <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <Leader>F  <Plug>(coc-format-selected)
nmap <Leader>F  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Mappings for CoCList
"" Show all diagnostics.
nnoremap <silent><nowait> <Leader>i  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <Leader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <Leader>c  :<C-u>CocList commands<cr>
" Find symbol of current doCument.
nnoremap <silent><nowait> <Leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <Leader>O :<C-u>CocList -I symbols<cr>
" Do default action for nexT item.
nnoremap <silent><nowait> <Leader>j  :<C-u>CocNext<CR>
" Do default action for preVious item.
nnoremap <silent><nowait> <Leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <Leader>l  :<C-u>CocListResume<CR>
" Open a new terminal and activate the CoC-set environment
nnoremap <Leader>nt :CocCommand python.createTerminal<CR>

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
