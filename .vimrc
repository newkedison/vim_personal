" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set noerrorbells

set encoding=utf-8
set langmenu=zh_CN.UTF-8
language messages zh_CN.UTF-8
set imcmdline
set guifont="Serif 14"
"let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936

set visualbell
set noerrorbells

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set t_Co=256
  syntax on
  set hlsearch
endif

if has("autocmd")
  au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
  au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
  au VIMEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
  au VIMLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

   """"""""""""""""""""""""""""""
   " Tag list (ctags)
   """"""""""""""""""""""""""""""
   "if MySys() == "windows"                "设定windows系统中ctags程序的位置
   "  let Tlist_Ctags_Cmd = 'ctags'
   "elseif MySys() == "linux"              "设定linux系统中ctags程序的位置
   "  let Tlist_Ctags_Cmd = '/usr/bin/ctags'
   "endif
   let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
   let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
   "let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口 

"WinManager相关设置
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
"在读取c/c++文件时，启动WinManager
autocmd BufWinEnter *.cpp,*.c,*.h,*.cc,*.hpp WManager
"设置winfileexplorer在列出文件的时候，把哪些文件放到后面去，方便查找
"这个设置是vim的内部设置，可以用:h suffixes查看其作用
set suffixes=.bak,~,.o,.info,.swp,.obj,.d,.s,.out
"因为列在上面的suffixes参数后的内容，到时候会被escape函数转义，所以没办法用regexp
"所以我修改了winfileexplorer插件的代码，在里面增加了这个变量，写在这里的匹配是不会被转义的
"需要注意的是，脚本会在最后自动加上一个$，所以不用自己加了
"多个Regexp用逗号分隔，内部不能出现逗号
"第一个是用于匹配带版本号的动态库文件
let g:explSuffixesNoEscape='\.so\(\.\d\+\)*'
"如果只剩下WinManager窗口，则自动退出
let g:persistentBehaviour=0
"下面的函数是我自己写的，也是用于实现只剩下WinManager窗口时自动退出
"虽然功能也能实现，但是存在着局限性，只能针对TagList和FileList两个窗口的情况
"如果是其他情况，需要自己改代码,的确不如插件自己提供的函数好
"不过写和调试也花了不少精力,就保留做纪念吧
"function! Exit_When_No_Other_Buffer()
"  let i = 1
"  while 1
"    let buf_count = winbufnr(i)
"    if buf_count != -1
"      let s = bufname(buf_count)
"      if s != "__Tag_List__" && s != "[File List]"
"        return
"      endif
"    else
"      break
"    endif
"    let i=i+1
"  endwhile
"  if tabpagenr('$') == 1
"    bdelete
"    quit
"  else
"    close
"  endif
"endfunction
"autocmd BufEnter __Tag_List__,\[File\ List\] nested 
"      \ call Exit_When_No_Other_Buffer()

"cscope相关设置
set cscopequickfix=s-,c-,d-,i-,t-,e-

"允许用<C-箭头键>切换buffer
"let g:miniBufExplMapWindowNavArrows = 1
"允许用<C-Tab>和<C-S-Tab>向前或向后选中Buf并直接打开
"使用时要注意,不要再miniBuf的buffer里面按,而是在任意一个buffer里面按
let g:miniBufExplMapCTabSwitchBufs = 1
"miniBuf的最大高度
let g:miniBufExplMaxSize = 1
"允许用<C-h, j, k, l>切换buffer
let g:miniBufExplMapWindowNavVim = 1
"buf超过多少个,才显示miniBuf,设为999就是为了不让他显示
let g:miniBufExplorerMoreThanOne = 999
"let g:miniBufExplForceSyntaxEnable = 1



let g:NeoComplCache_EnableAtStartup = 1 
let g:SuperTabDefaultCompletionType="context"

if version >=603
	set helplang=cn
endif
let mapleader=","

map <leader>s :source ~/.vimrc<cr>
map <leader>e :split ~/.vimrc<cr>
au! bufwritepost .vimrc source ~/.vimrc

nnoremap ; :

nnoremap <leader>q :q

set linespace=2
au bufwritepost my_desert.vim colorscheme my_desert

nnoremap <space> 3<C-D>
nnoremap <A-space> 3<C-U>

imap <Nul> <Space>
inoremap <C-o> <C-x><C-o>
inoremap <C-i> <C-x><C-i>

set tabstop=2     "实际Tab键的宽度
set expandtab     "用空格代替Tab键,这样当按了Tab键后,会被替换成两个空格,删除的时候也是按空格来删除
set autoindent    "自动缩进,在VIM能识别的语法下,会自动输入Tab,缩进的宽度由下一行的设置确定
set shiftwidth=2  "设置自动缩进的宽度

"From:http://hi.baidu.com/legolaskiss/blog/item/0f8cc3ea8ac553d0d539c92c.html
"后来又参考了其他的资料,进行了较大改动,因为Tab键会用于补全,所以不能用来跳过右半部分
inoremap ( ()<left>
inoremap [ []<left>
inoremap { <c-r>=BigBracket()<CR>
inoremap ' <c-r>=ReplaceQuote("'")<CR>
inoremap " <c-r>=ReplaceQuote("\"")<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
"替换左花括号,如果当前行有内容,不替换,如果当前行只是空字符,则自动加上右括号,并且中间放一个空行
"这样做是因为有时候需要用单个大括号,表示折叠,所以不能替换
function! BigBracket()
  if getline('.') =~ '^\s*$'
    return "{}\<left>\<CR>\<ESC>O"
  else
    return "{"
  endif
endfunction
"function! LeaTab()
    "let col = col('.') - 1
    "if col == strlen(getline('.'))    "原作者函数中没有这三行,当在行末按Tab时,会被映射成<Right>
	    "return "\<tab>"
    "endif
    "if ")]}'\"" !~ getline('.')[col]
        "return "\<tab>"
    "endif
    "return "\<RIGHT>"
"endfunction
"inoremap <tab> <c-r>=LeaTab()<cr>
function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endfunction
function! ReplaceQuote(c)
  "这里处理整行没内容,然后输入引号的情况,这种情况不替换
  "因为很可能是注释
  if getline('.') =~ '^\s*$'
    return a:c
  endif
  if getline('.')[col('.') - 1] == a:c
    return "\<Right>"
  else
    return a:c . a:c . "\<Left>"
  endif
endfunction

"重新映射删除键,使得光标在两个双引号或者单引号之间的时候,优先删除右边的一个
function! NewBackSpace()
  let col = col('.') - 1
  if col > 0 && "'\"" =~ getline('.')[col]
    if getline('.')[col] == getline('.')[col-1]
      return "\<Del>"
    endif
  endif
  return "\<BackSpace>"
endfunction
"inoremap <BackSpace> <c-r>=NewBackSpace()<cr>
inoremap <S-BackSpace> <Right><BackSpace>

"使得光标在不同窗口中跳转，Tab是向下/向右跳转，Shift+Tab则相反
nnoremap <S-Tab> <C-w>W
nnoremap <Tab> <C-w>w
nmap <F6> :nohls<cr>
"设置/取消高亮光标所在行和所在列
map <F5> :set cursorline cursorcolumn
map <S-F5> :set nocursorline nocursorcolumn

"直接编译执行当前文件,目前仅支持Python(*.py)
function! RunSource()
  let ext = expand("%:e") "分解出扩展名
  if ext == 'py'   "处理Python文件
    "调用python,注意如果在Windows，要把python.exe的路径加入PATH环境变量
    exe "!python ".expand("%:p")
  elseif ext == 'c' || ext == 'cpp'
    if filereadable('Makefile')
      make
    else
      echo "c和cpp文件必须提供Makefile才能自动编译"
    endif
  else   "如果扩展名不支持
    echo "目前只支持以下文件格式:"
    echo "(*.py), Python文件"
    echo "(*.c), c语言文件（需有Makefile）"
    echo "(*.cpp), c++文件（需有Makefile）"
  endif
endfunction
map <F9> :w<bar>call RunSource():cw

"map <F9> :w<bar>:make<cr>:cw<cr><cr><cr>

colorscheme my_desert
au BufRead,BufNewFile,ColorScheme *.tips setfiletype tips
au BufRead,BufNewFile,ColorScheme *.lnt setfiletype c
nnoremap <F2> :call setline('.', strftime('%Y-%m-%d %H:%M:%S', localtime()))
nmap <F4> ^y$:<c-r>=GotoHelp(@0)<cr><cr>
function! GotoHelp(cmd)
	let c=a:cmd
	if match(c,'^:h .\+$') != -1
		return c
	else
		return "echo '当前行不是查询帮助的命令'"
	endif
endfunction
set ignorecase
autocmd BufEnter * lcd %:p:h
vmap <c-c> "+y<esc>
nmap <c-v> <esc><esc>"+p

set nobackup
set nu
set scrolloff=5

function! MaximizeWindow()
  silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

"自动添加时间戳,来源http://www.yegong.net/timestamp-script-for-vim/
"根据不同的文件类型,自动以注释的方式写入当前时间,
"如果已经存在一个旧的时间戳,自动更新,如果不存在,在第一行
"function! TimeStamp(...)
"    let sbegin = ''
"    let send = ''
"    if a:0 >= 1
"        let sbegin = a:1.' '
"    endif
"    if a:0 >= 2
"        let send = ' '.a:2
"    endif
"    let pattern = sbegin . 'Last Change: .\+'
"        \. send
"    let pattern = '^\s*' . pattern . '\s*$'
"    let row = search(pattern, 'n')
"    let now = strftime('%Y-%m-%d %H:%M:%S',
"        \localtime())
"    let now = sbegin . 'Last Change: '
"        \. now . send
"    if row == 0
"        call append(0, now)
"    else
"        call setline(row, now)
"    endif
"endfunction

"au BufWritePre _vimrc,*.vim,.vimrc   call TimeStamp('"')
"au BufWritePre *.c,*.h        call TimeStamp('//')
"au BufWritePre *.cpp,*.hpp    call TimeStamp('//')
"au BufWritePre *.cxx,*.hxx    call TimeStamp('//')
"au BufWritePre *.java         call TimeStamp('//')
"au BufWritePre *.rb           call TimeStamp('#')
"au BufWritePre *.py           call TimeStamp('#')
"au BufWritePre Makefile       call TimeStamp('#')
"au BufWritePre *.txt          call TimeStamp()
"au BufWritePre *.php
"    \call TimeStamp('<?php //', '?>')
"au BufWritePre *.html,*htm
"    \call TimeStamp('<!--', '-->')

"设置自动折行，如果一行显示不下去，会自动显示成多行，VIM默认是打开这个选项，这句不写也行
"不过自动折行有个小问题，就是按j和k进行光标移动的时候，一次会跳过整行，导致要把光标移动到一行的中间，要按很多次l才行
"还好有gj和gk这两个也是移动的命令，可以满足要求，而且对于没有折行的，也是正常。所以这里直接把j和k映射上去
set wrap
nnoremap j gj
nnoremap k gk

"设置每行最大宽度为80，如果超过这个宽度，会自动换行，但是如果一行就是一个超过80个字
"符的单词，不会被自动换行，只有从后面添加时，才会换行，如果从前面或者中间添加，
"就不会换行
"如果要中文也能正确换行，就要加上fo+=Mm这一句
"目前这个暂时不用，因为如果要复制到Word里面，那这鲎远?换行就帮倒忙了
"set tw=80 fo+=Mm

if v:version >= 700
    set completeopt=menu,longest,preview
                            " 自动补全(ctrl-p)时的一些选项：
                            " 多于一项时显示菜单，最长选择，
                            " 显示当前选择的额外信息
endif
set confirm                 " 用确认对话框（对于 gvim）或命令行选项（对于
                            " vim）来代替有未保存内容时的警告信息
set display=lastline        " 长行不能完全显示时显示当前屏幕能显示的部分。
                            " 默认值为空，长行不能完全显示时显示 @。
set showcmd                 " 在状态栏显示目前所执行的指令，未完成的指令片段亦
                            " 会显示出来
set cmdheight=1             " 设定命令行的行数为 1
set laststatus=2            " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=%F%m%r,%Y,%{&fileformat}\ \ \ ASCII=\%b,HEX=\%B\ \ \ %l,%c%V\ %p%%\ \ \ [\ %L\ lines\ in\ all\ ]
                            " 设置在状态行显示的信息如下：
                            " %F    当前文件名
                            " %m    当前文件修改状态
                            " %r    当前文件是否只读
                            " %Y    当前文件类型
                            " %{&fileformat}
                            "       当前文件编码
                            " %b    当前光标处字符的 ASCII 码值
                            " %B    当前光标处字符的十六进制值
                            " %l    当前光标行号
                            " %c    当前光标列号
                            " %V    当前光标虚拟列号 (根据字符所占字节数计算)
                            " %p    当前行占总行数的百分比
                            " %%    百分号
                            " %L    当前文件总行数
  "处理QuickFix窗口乱码,见:h make
	"function! QfMakeConv()
	   "let qflist = getqflist()
	   "for i in qflist
	     "let i.text = iconv(i.text, "utf-8", "euc-cn")
	   "endfor
	   "call setqflist(qflist)
	"endfunction

	"au QuickfixCmdPost make call QfMakeConv()

  "几个和make相关的映射
  "make后面加上感叹号，使得不自动跳转到第一个错误，
  "copen是打开QuickFix，不论是否有错误
  map <leader>m :w<bar>make!<cr>j:copen<cr>
  "在调用make后继续调用make run，要求Makefile里面要有run这一节
  map <leader>ma :w<bar>make<cr>:make run<cr>

  "通过a.vim插件，实现在.h和.cpp之间切换，因为有其他<leader>a开头的映射
  "所以直接输入<leader>a要等1秒才能执行，所以这里多定义一个<leader>aa，
  "这样按起来比较流畅
  map <leader>a :w<bar>A<cr>
  map <leader>aa :w<bar>A<cr>

  "c.vim的配置
  "设置日期和时间的格式,如果不设置,将显示为中文,这样不太合适
  let g:C_FormatDate = '%Y-%m-%d'
  let g:C_FormatTime = '%H:%M:%S'
  let g:C_MapLeader=mapleader
  let g:C_CFlags= '-Wall -g -O0 -c -std=c++0x'
  let g:C_Libs= '-lm -pthread'

  map <leader>dr :run macros/gdb_mappings.vim<bar>call gdb("gdb")<cr>
  map <leader>dv :bel vsplit gdb-variables<bar>silent! !echo a<cr>i<ESC>

  let g:vimgdb_debug_file = ""
  "run macros/gdb_mappings.vim

  nmap <leader>du :silent! !echo a<cr>i<ESC>
  inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
let g:pydiction_location='~/.vim/pydiction/complete-dict'
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python compiler pylint
let g:pylint_onwrite = 0 "不在保存py文件时自动检查,因为那很浪费时间
let g:pylint_show_rate = 1
autocmd FileType python set completeopt-=preview

"如果版本号大于7.3，则启用持久化撤销的功能
if version >=703
  set undofile
endif

set go-=m

ino <M-k> <Up>
ino <M-j> <Down>
ino <M-h> <Left>
ino <M-l> <Right>
cnoremap <M-h> <Left>
cnoremap <M-l> <Right>

"将命令行的结果，输出到当前的文件中
"使用方法:
":ShowCommand 命令
"如  :ShowCommand reg
"command是定义一个用户自定义函数
"-nagrs=1规定这个函数接受一个参数
"-complete=command规定这个函数可以接受Ex命令补全(其实我也不太理解是什么意思,应该是支持在命令行按Tab键补全一些命令的名字)
"ReadCommand是函数名，后面全部是函数体，函数体中，注意<args>在实际命令中，会替换为实际的参数
"函数体的内容比较简单，主要是利用redir命令，把输出先重定向到一个临时寄存器，然后粘贴到文件，最后结束重定向
command! -nargs=1 -complete=command ReadCommand redir @"> 
    \ | exe "<args>" | normal $p | redir END

set colorcolumn=81

map <leader>stl :sp ~/share/vim/vimfiles/after/syntax/cpp/stl.vim<cr>

"取消securemodelines这个插件，这个插件可以检查modeline，仅保留一些安全的设置
"但是我觉得这个插件管的太严格了，又不想删掉，这里定义了这个变量，使得这个插件不会加载
"如果要加载插件，必须把这行注视掉，改成1是没用的
let g:loaded_securemodelines = 0

nmap <leader>z zA

"在用ctags生成命令的时候,生成一些特定的C++信息
"--c++-kinds=+p  : 为C++文件增加函数原型的标签
"--fields=+iaS   : 在标签文件中加入继承信息(i)、类成员的访问控制信息(a)、以及函数的指纹(S)
"--extra=+q      : 为标签增加类修饰符。注意，如果没有此选项，将不能对类成员补全 
map <leader>tag :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"和OmniComplete补全相关的一些映射,pumvisible()函数返回现在补全列表是否可见
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>" 
"如果补全列表可见,把j和k映射为上下移动,否则还是保持原样
inoremap <expr> j          pumvisible()?"\<C-N>":"j"
inoremap <expr> k          pumvisible()?"\<C-P>":"k"

"OminCppComplete相关设置
"不在全局范围内搜索,这样可以减少很多没用的匹配
let g:OmniCpp_GlobalScopeSearch = 0
"补全列表中会列出函数原型,同时completeopt参数会加上preview选项,
"有了preview选项的效果,就是会多出现一个窗口,列出更详细的函数原型
"虽然这个窗口挺有用的,但是看完之后就失去作用了,还要手动关闭,比较麻烦
"所以,下面会用一个autocmd把这个窗口关掉
"需要注意的就是,如果要取消这个效果,除了把下面的参数改为0外,还要
":set completeopt-=preview
let g:OmniCpp_ShowPrototypeInAbbr = 1
"在按两次冒号后,会自动弹出补全列表
let g:OmniCpp_MayCompleteScope = 1

"这里就是自动关闭上面提到的函数原型窗口,关闭的前提都是补全列表已经关闭
"第一句是在插入模式下光标有移动就关闭,我觉得关闭的太快了,
"如果参数很长,可能还没能记住,所以被我注释掉了
"第二句是在离开插入模式的时候,我觉得这个时机还算不错
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
autocmd InsertLeave * if pumvisible() == 0|pclose|endif 

"DoxygenToolkit 配置
let g:DoxygenToolkit_briefTag_pre = "@brief "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@retval "
let g:DoxygenToolkit_authorName="newkedison<newkedison@gmail.com>"
let g:DoxygenToolkit_startCommentTag = "/** "
let g:DoxygenToolkit_startCommentBlock = "/* "
"如果设置为C++，则注释采用//，默认是使用/**/，我个人是倾向于//方式的注释
"但是考虑到vim的折叠只能折叠/**/格式的注释，所以下面这个就不设置了
"let g:DoxygenToolkit_commentType="C++"
let g:DoxygenToolkit_remainParameterType = "no"

"隐私设置，这个文件夹里面的所有文件，关闭persistent-undo和viminfo功能
autocmd BufWritePre ~/.diary/** setlocal noundofile viminfo=

au BufNewFile,BufRead *.doxygen setfiletype doxygen

au FileType gitcommit g/^#.*\n^#\@!/exec "norm o"
au FileType gitcommit v/^#/s/^/#/

" VIM: sw=2 ts=2 fileencoding=utf-8
