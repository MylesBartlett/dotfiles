" ===================================
" Plugins
" ===================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Turn your browser¹ into a Neovim client 
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

Plug 'airblade/vim-rooter'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-eunuch'
Plug 'simeji/winresizer'
" disables search highlighting when you are done searching and re-enables it when you search again
Plug 'romainl/vim-cool'
Plug 'frazrepo/vim-rainbow'
Plug 'kshenoy/vim-signature'

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
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

" ---------- Python ----------
Plug 'sheerun/vim-polyglot'
Plug 'raimon49/requirements.txt.vim'  " syntax highlighting for requirements.txt
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'michaeljsmith/vim-indent-object'

" ---------Status bar --------
Plug 'itchyny/lightline.vim' 

" --------- Editing ---------
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'farmergreg/vim-lastplace'  " remember cursor position
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'  " line stuff up with ga motion
Plug 'tpope/vim-repeat'  " repeat supported plugin maps
" Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast, powerful configuration.
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings

" --------- Writing ---------
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Color scheme
Plug 'lifepillar/vim-gruvbox8'
Plug 'franbach/miramare'

" LSP
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-highlight', 
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc-prettier', 
Plug 'neoclide/coc-lists',

call plug#end()

if has('vim_starting')
    set encoding=utf-8
endif
scriptencoding utf-8

" Appearance
set termguicolors     " enable true colors support
set background=dark
let g:gruvbox_plugin_hi_groups = 1
let g:gruvbox_italics = 1
let g:gruvbox_italicize_strings = 0
let g:gruvbox_bold = 1
 colorscheme gruvbox8
let g:miramare_enable_italic = 1
let g:miramare_disable_italic_comment = 1
" colorscheme miramare
let g:rainbow_active = 1

" General Settings
set undofile " Maintain undo history between sessions
set undodir=~/.config/nvim/undodir

set number
set relativenumber
set autoread
set backspace=indent,eol,start
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

" Folding
set foldmethod=manual 

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Highlighting in cursor line
set cursorline
" hi CursorLine guibg=#666666
" Vertical line delineating column-limit
set colorcolumn=101
hi ColorColumn ctermbg=lightcyan guibg=#3C3836
" Highlight characters that are over the column-limit
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

" Keybindings
" General
let mapleader = " "
nnoremap <Leader><Leader> zz
nnoremap U <C-R> 
nnoremap <Leader>0 :source ~/.config/nvim/init.vim <Enter>
nnoremap \ :set iskeyword-=_<CR>
nnoremap <C-\> :set iskeyword+=_<CR>
nnoremap <Leader>S :bufdo update<CR>
nnoremap <Leader>s :update<CR>
vmap <Leader>s <Esc><C-s>gv

nnoremap <Leader>; q:
vnoremap <Leader>; q:
" Save and Quit buffer
nnoremap <silent> <Leader>x :x<CR>
vmap              <Leader>x <Esc><Leader>x


"Replaces the word under cursor for whatever you want; after that, you can keep pressing  . and
"it will keep substituting all the instances of the original word (ala multiple cursors). You can 
"skip them with n (as you would in a normal search). The second mapping goes the other way around:
"substitutes upwards.
nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

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

" Line movement
nnoremap <CR> o<Esc>
nnoremap <Leader><CR> O<Esc>
" Make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" Enable easy tab-switching
" In normal mode
noremap <C-h> <C-\><C-n><C-w>h
noremap <C-j> <C-\><C-n><C-w>j
noremap <C-k> <C-\><C-n><C-w>k
noremap <C-l> <C-\><C-n><C-w>l

" In terminal mode
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w> <C-\><C-n>

" ----------------------------------------------------------------------------
" ?ie | entire object
" ----------------------------------------------------------------------------
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

" ----------------------------------------------------------------------------
" ?il | inner line
" ----------------------------------------------------------------------------
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>

" Buffer-related mappings
" gl: Go to Last buffer
nnoremap <silent> gl :buffer#<CR>

" Commenting with Commentary
nmap <C-c> <Plug>Commentary
xmap <C-c>  <Plug>Commentary
omap <C-c> <Plug>Commentary

nmap <Leader>yw ysiw
nmap <Leader>yW ysiW
" Surround like delete/change surrounding function calls
nmap <silent> dsf ds)db
nnoremap <silent> csf [(cb

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

" Use RG for grepping
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

nnoremap <Leader>rs :s/\<<C-r><C-w>\>/
nnoremap <Leader>rS :%s/\<<C-r><C-w>\>/
nnoremap <Leader>rg :grep <<C-r><C-w>\> <bar> cfdo %s/\<<C-r><C-w>\>/

" Toggle CHADTree
nnoremap <Leader>v <cmd>CHADopen<cr>
" Clear quick-fix list
nnoremap <Leader>l <cmd>call setqflist([])<cr>

" Pydoctring
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
nmap <silent> <Leader>_ <Plug>(pydocstring)
let g:pydocstring_formatter = 'google'

" =============
" CoC settings
" =============
" TextEdit might fail if hidden is not set.
set hidden
let g:coc_snippet_next = '<tab>'
nmap <silent> <M-CR> <Plug>(coc-fix-current)
autocmd BufWritePre *.py :CocCommand pyright.organizeimports

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
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
			 \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> gh <Plug>(coc-diagnostic-info)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
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
nnoremap <silent><nowait> <Leader>w :<C-u>CocList -I symbols<cr>
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
      \ 'colorscheme': 'seoul256',
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
