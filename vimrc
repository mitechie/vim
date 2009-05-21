" Vimrc - Richard Harding
"
" Started with base by: Christian Andersen <http://phuzz.org>
"
" Shortcuts:
" tab       - auto complete ctags/etc
" C-f       - OnmiComplete
"
" t         - open NERDTree
" F8        - Open Taglist window
"
" Y         - yank to the end of the line
" C-s       - save file
" C-m       - :make current file
"
" C-j       - move cursor to split below
" C-k       - move cursor to split above
" C-h       - move cursor to split left
" C-l       - move cursor to split right
" (above also works in insert mode)
"
" C-n       - clear the current search hilight
" C-t       - open the unit test file test_xxxxx
" 
" C-p       - tab complete with snipMate 
" C-r<tab>  - show available snippets from snipMate
"
" -         - shrink size of current split with minus sign
" +         - increase size of current split with =
" 
" Alt-,     - increase split width
" Alt-.     - decrease split width
"
" f2        - close current window
"
" ,v        - open .vimrc file for editing
" ,V        - reload .vimrc
" ,c        - transforms camelCase to camel_case
" ,m        - :make current file
" ,t        - open todo list
" ,T        - run HTML Tidy on the content
" ,b        - open buffer list
"
" <CR>      - create newline with carriage return in normal mode 
" <SPACE>   - open the current fold we're on
"
" gc        - comment the highlighted text
" ggc       - comment out the current line
"
" PERL
"   F1      - run Perldoc for the current word
"
" PHP
"   C-u     - run the PHPDOC command for the function we're on
"               note: doesn't work if pamams wrap lines
"
" Version Control
"  ,d       - svn diff local changes
"  ,z       - bzr diff local changes
"
"   Git
"     ,gd       - :GitDiff
"     ,gd       - :GitDiff --cached
"     ,gs       - :GitStatus 
"     ,gl       - :GitLog 
"     ,ga       - :GitAdd 
"     ,gA       - :GitAdd <cfile> 
"     ,gc       - :GitCommit 
"     <Enter>   - In git-status buffer :GitAdd <cfile> 
"
" TwitVim info:
" F7        - load identica
" F8        - load twitter
" ,g        - load the user you see in an @reply
"
"
" ~/.vim/twitvim.vim
" 
" let twitvim_enable_python = 1
" let twitvim_login = "user:pass"
"
" function! Switch_to_twitter()
"    let g:twitvim_api_root = "https://twitter.com"
"    FriendsTwitter
" endfunction
"
" function! Switch_to_identica()
"    let g:twitvim_api_root = "https://identi.ca/api"
"    FriendsTwitter
" endfunction
"
" command! ToTwitter :call Switch_to_twitter()
" command! ToIdentica :call Switch_to_identica()
" nnoremap <F7> :ToIdentica<cr>
" nnoremap <F8> :ToTwitter<cr>
"
"
"
" basics sets {{{
let mapleader = "," " change the leader to be a comma vs slash
set textwidth=80        " Try this out to see how textwidth helps
set nocompatible        " use vim defaults
set ls=2                " allways show status line
set tabstop=4           " numbers of spaces of tab character
set shiftwidth=4        " numbers of spaces to (auto)indent
set scrolloff=3         " keep 3 lines when scrolling
"set cursorline          " have a line indicate the cursor location
set cindent             " cindent
set autoindent          " always set autoindenting on
set showcmd             " display incomplete commands
set ruler               " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell        " turn off visual bell
set nobackup            " do not keep a backup file
set number              " show line numbers
set title               " show title in console title bar
set ttyfast             " smoother changes
set modeline            " last lines in document sets vim mode
set modelines=3         " number lines checked for modelines
set shortmess=atI       " Abbreviate messages
set nostartofline       " don't jump to first character when paging
set viminfo='100,f1
set backspace=start,indent,eol
set matchpairs+=<:>     " show matching <> (html mainly) as well
set spell
set expandtab           " tabs are converted to spaces, use only when required
set sm                  " show matching braces, somewhat annoying...

" move freely between files
set whichwrap=b,s,h,l,<,>,[,]   

" set a git statusline 
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ %=[POS=%04l,%04v][%p%%]\ [LEN=%L]\ %#StatusLineNC#\ Git\ %#Folded#\ %{GitBranchInfoTokens()[0]}\ %#StatusLine# 


" Make command line two lines high
set ch=3

" wildmenu makes the tab complete act more like a bash prompt
set wildmenu        
set wildmode=longest,list

"""""" {{{ Disabled
" 

"set smartindent        " smart indent
"set noignorecase       " don't ignore case
"set ttyscroll=0        " turn off scrolling, didn't work well with PuTTY


"set autowrite      " auto saves changes when quitting and swiching buffer
"set nowrap         " don't wrap lines
" }}}

" MISC {{{

" Y yanks to the end of the line
nmap Y y$


" Test for the pyflakes file
filetype plugin indent on

",v brings up my .vimrc
",V reloads it -- making all changes active (have to save first)
map <leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" shortcuts for saving with ctrl-s
nmap <c-s> :w<CR>
vmap <c-s> <esc><c-s>
imap <c-s> <esc><c-s> 

" Turns visually selected camelCase into camel_case
vnoremap <leader>c :s/\v\C(([a-z]+)([A-Z]))/\2_\l\3/g<CR>

" Run Make with ctrl-m
" or ,m
map <c-m> :make<CR>
map <silent> <leader>m :make<CR>

nmap <CR> o<Esc>            " quick insertion of a newline

"Space opens a fold
nmap <Space> zo

" }}}



""""" SPLITS and Windows {{{{

" Ctrl-jklm  changes to that split
map <C-j> <C-W>j
map <C-k> <C-W>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" fast switching / maximization of window panes
" and vsplits
"map <C-h> <C-W>h<C-W><bar>
"map <C-l> <C-W>l<C-W><bar>

" and lets make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
imap <C-W> <C-O><C-W>

" use - and + to resize horizontal splits
map - <C-W>-
map + <C-W>+

" and for vsplits with alt-< or alt->
map <M-,> <C-W>>
map <M-.> <C-W><

" F2 close current window (commonly used with my F1/F3 functions)
noremap <f2> <Esc>:close<CR><Esc>

" }}}



""""" SEARCH {{{

set hlsearch            " highlight searches
set incsearch           " do incremental searching
set ignorecase          " ignore case when searching 

" Press Ctrl-N to turn off highlighting.
nmap <silent> <C-N> :silent noh<CR>

" }}}


" mapping to make movements operate on 1 screen line in wrap mode {{{
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

" }}}



" if version>=600 {{{
if version>=600
    syntax on          " syntax highlighing

    "---- Options for Windows
    if has("gui_running")
        set guifont=Liberation\ Mono\ 7" use this font 
        set lines=75      " height = 50 lines
        set columns=180       " width = 100 columns
        set background=dark  " adapt colors for background
        set keymodel=
        set mousehide
		"colorscheme tango2
		"colorscheme lucius
		colorscheme wombat


        " To set the toolbars off (icons on top of the screen)
        set guioptions-=T
    else
        set background=dark   " adapt colors for dark background
        " colorscheme tango2   " use this color scheme
		"colorscheme lucius
		colorscheme wombat
    endif
endif
" }}}



""""" Commands {{{

" Auto change the directory to the current file I'm working on
autocmd BufEnter * lcd %:p:h 

" Filetypes (au = autocmd)
au filetype help set nonumber      " no line numbers when viewing help
au filetype help nnoremap <buffer><cr> <c-]>   " Enter selects subject
au filetype help nnoremap <buffer><bs> <c-T>   " Backspace to go back

"If we're editing a mail message in mutt change to 70 wide and wrap
"without linex numbers
augroup mail
    autocmd!
    autocmd FileType mail set textwidth=70 wrap nonumber nocursorline 
augroup END
    
" File formats
au BufNewFile,BufRead  *.pls set syntax=dosini
au BufNewFile,BufRead  modprobe.conf set syntax=modconf

" automatically give executable permissions if file begins with #! and contains
" '/bin/' in the path
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile> | endif | endif

" This is for perldoc.vim
autocmd BufNewFile,BufRead *.pl map <F1> :Perldoc<cword><CR>
autocmd BufNewFile,BufRead *.pl setf perl
autocmd BufNewFile,BufRead *.pl let g:perldoc_program='/usr/bin/perldoc'

" Use perl compiler for all *.pl and *.pm files.
autocmd BufNewFile,BufRead *.pl compiler perl

" PHP Specific config stuff 
source ~/.vim/php/php-doc.vim
source ~/.vim/php/phpfolding.vim

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd BufRead *.php map <C-u> :set paste<CR>:call PhpDoc()<CR>:set nopaste<CR>i
autocmd BufRead *.php set makeprg=php\ -l\ %
autocmd BufRead *.php set errorformat=%m\ in\ %f\ on\ line\ %l
autocmd BufRead *.php let php_folding=0 

" HTML Stuff
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS

" automatically minimize .js files if we can
" requires the jsmin.pl script and install in CPAN of 
" MINIFY::Javascript and MINIFY::CSS
au BufWritePost *.js silent !jsmin.pl %
au BufWritePost *.css silent !jsmin.pl %

" PYTHON Stuff
" plugin that adds support for pdb from within vim
" au FileType python source ~/.vim/python/VimPdb.vim
au FileType python source ~/.vim/python/jpythonfold.vim

au FileType python set omnifunc=pythoncomplete#Complete

" Syntax checking entire file
" Usage: :make (check file)
" :clist (view list of errors)
" :cn, :cp (move around list of errors)
au BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

au! BufRead,BufNewFile *.dtpl setfiletype htmldjango

" }}}



" {{{ Autocompletion using the TAB key

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
func! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t
set completeopt-=preview
set completeopt+=longest

" }}} Autocompletion using the TAB key



" NERDTree
map t :NERDTree<CR>

" For Taglist {{{
" search for tags file in parent directories
set tags=tags;/
 
nnoremap <silent> <F8> :Tlist<CR> 
nnoremap <silent> <F9> :TlistSync<CR>
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Sort_Type = "name"
let Tlist_Compact_Format = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Use_SingleClick = 1 

"}}}

" enable html tag matching
source ~/.vim/ftplugin/html_closetag.vim

" Settings for the tasklist plugin
map <leader>t <Plug>TaskList
let g:tlTokenList = ["FIXME", "TODO", "todo"]


" enable a shortcut for tidy using ~/.tidyrc config
map <Leader>T :!tidy -config ~/.tidyrc<cr><cr> 


" UNIT TESTS
" toggle between test file and normal file
"let g:unit_test_prefix='test_'
"map <C-t> <esc>:TUT<CR>

""""" Completion {{{

" setup omnicompletion for file types {{{
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

" map Control-F to the onmicomplete
imap <C-f> <C-x><C-o>

" }}}


""""" VERSION CONTROL {{{

" Commands
" ,d svn diff of local changes
" ,z bzr diff of local changes
   
function! Svndiff2()
    let dir = expand('%:p:h')
    let fn = expand('%')
    execute ":vert diffsplit" . dir . "/.svn/text-base/" . fn . ".svn-base"
    unlet fn dir
    return
endfunction

function! Svndiff()
    let fn = expand('%:p')
    new
    set ft=diff
    execute ":.!svn diff -r BASE " . fn
    unlet fn
    return
endfunction

nmap <silent> <leader>D :call Svndiff()<CR>
nmap <silent> <leader>d :call Svndiff2()<CR>

func! BZRDiff()
    let filename = expand("%")
    let tempfile = "/tmp/" . expand("%:t")
    let shell_command = "bzr cat -r-1 " . filename . " > " . tempfile

    call system(shell_command)
    execute ":vert diffsplit " . tempfile

    unlet filename tempfile shell_command
endfunc
comm! BD call BZRDiff()
nmap <silent> <leader>z :call BZRDiff()<CR>

" }}}


source ~/.vim/twitvim.vim


""""" Custom Commands {{{

" Clear out all of the debug dump in the current buffer
function! RHClearDebug()
    if &filetype == 'PHP' 
        execute "g/var_dump/d"
    elseif &filetype == 'JAVASCRIPT'
        execute "g/console.log/d"
    endif
endfunction

if !exists(":RHClearDebug")
    command RHClearDebug :call RHClearDebug()
endif


" }}}
