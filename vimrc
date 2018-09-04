" brew install vim --with-lua --with-override-system-vi
" pip install yapf
" pip install flake8
" vim +PluginInstall +qall
" cd ~/.vim/bundle/YouCompleteMe/
" ./install.py


" General {{{
syntax on
set nocompatible
set list
set listchars=tab:>-,trail:-
set hlsearch
set ignorecase
set incsearch
set expandtab
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set number
set numberwidth=5
set relativenumber
set mouse=v
set tags=~/.tags;
set autochdir
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
map <F3> :tabp<CR>
map <F4> :tabn<CR>
map <F5> :call RunScripts()<CR>
func! RunScripts()
    exec "w"
    if &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'sh'
        exec "!time bash %"
    elseif &filetype == 'html'
        exec "!open -a 'Google Chrome' %"
    endif
endfunc
autocmd BufRead,BufNewFile *.vue set filetype=html
autocmd FileType python match OverLength /\%80v.\+/
autocmd BufReadPost *
    \ if line("'\"") > 0 |
    \     if line("'\"") <= line("$") |
    \         exe("norm '\"") |
    \     else |
    \         exe "norm $" |
    \     endif |
    \ endif
autocmd FileType html,css,javascript,yaml set
    \ colorcolumn=79
    \ shiftwidth=2
    \ tabstop=2
autocmd FileType python set
    \ colorcolumn=79
    \ shiftwidth=4
    \ tabstop=4
" }}}


" Bundle {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
filetype plugin indent on
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'google/yapf', { 'rtp': 'plugins/vim' }
Plugin 'Yggdroot/indentLine'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'w0rp/ale'
Plugin 'nvie/vim-flake8'
Plugin 'altercation/vim-colors-solarized'
" }}}


" YouCompleteMe {{{
let g:ycm_python_binary_path = ''
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_cache_omnifunc = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 0
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_filetype_blacklist = {
    \ 'html' : 1,
    \ 'css' : 1 }
set completeopt=longest,menu
noremap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}


" NERDTree {{{
map <F2> :NERDTreeToggle<CR>
let NERDTreeWinSize = 40
let NERDChristmasTree = 1
let NERDTreeChDirMode = 1
let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1
let NERDTreeIgnore = ['\~$', '\.pyc$', '\.swp$']
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}


" Airline {{{
set t_Co=256
set noshowmode
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'luna'
" }}}


" Emmet {{{
let g:user_emmet_leader_key = '<C-Y>'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" }}}


" Neocomplete {{{
let g:neocomplete#enable_at_startup = 0
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
autocmd FileType html,css NeoCompleteEnable
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}


" Yapf {{{
map <C-Y> :YAPF<CR>
" }}}


" IndentLine {{{
let g:indentLine_char = '¦'
let g:indentLine_color_term = 239
let g:indentLine_enabled = 1
autocmd BufRead,BufEnter,BufNewFile * IndentLinesReset
" }}}


" Ctrlp {{{
let g:ctrlp_mruf_max = 500
let g:ctrlp_max_history = 500
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|svn)$',
  \ 'file': '\v\.(swp|pyc)$'
  \ }
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip
noremap <leader><leader> :CtrlPMixed<cr>
noremap <leader><leader><leader> :CtrlPMRU<cr>
" }}}


" Ale {{{
let g:ale_linters = { 'python': ['flake8'] }
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '✗'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:pymode_rope = 0
let g:ale_emit_conflict_warnings = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }}}


" Color {{{
set background=dark
set guifont=Monaco\16
colorscheme solarized
highlight  LineNr      cterm=NONE        ctermbg=NONE       ctermfg=darkgrey   guibg=NONE        guifg=NONE
highlight  Pmenu       cterm=NONE        ctermbg=black      ctermfg=lightblue  guibg=black       guifg=lightblue
highlight  PmenuSel    ctermbg=black     ctermfg=darkgreen  guibg=black        guifg=lightgreen
highlight  ColorColumn ctermbg=black     ctermfg=white      guibg=#ff4500
highlight  OverLength  ctermbg=red       ctermfg=white      guibg=#592929
" }}}