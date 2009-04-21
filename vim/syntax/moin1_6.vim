" MoinMoin structured text syntax file
" Filename:    moin.vim
" Language:    MoinMoin structured text
" Maintainer:  Gustavo Niemeyer <niemeyer@conectiva.com>
" Last Change: Sun, 02 Mar 2008 23:42:31 -0300

" remove any old syntax stuff hanging around
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn sync lines=30

syn region  moinSettings      start="\%^@@ Syntax:" end="^[^@]"me=e-1 end="^$" nextgroup=moinPragma
syn region  moinPragma        start="^#" end="^$" contained
syn region  moinItalic        start="''" end="''"
syn region  moinBold          start="'''" end="'''"
syn region  moinUnderline     start="__" end="__"
syn match   moinSub           ",,.{1,40},,"
syn match   moinSup           "\^.\{-}\^"
syn region  moinCode          start="^{{{\z([^#]*\)" keepend end="\z1}}}"
syn match   moinCode          "{{{[^$]\{-}}}}"
syn region  moinCode          start="`" end="`"
syn cluster moinTextMarkup    contains=moinItalic,moinBold,moinCode,moinUnderline,moinSup,moinSub
syn match   moinComment       "^##.*$"
syn region  moinInlineComment start="/\*" end="\*/"
syn region  moinMacro         start="<<" end=">>"
syn region  moinStrike        start="--(" end=")--"
syn region  moinHeader        start="^\z(=\{1,5}\) " end=" \z1$" oneline
syn match   moinRule          "^-\{4,}$"
syn match   moinSmileys       "\(\s\|\_^\)\(%)\|(!)\|(./)\|/!\\\|:(\|:)\|:))\|:-(\|:-)\|:-))\|:-?\|:D\|:\\\|:o\|;)\|;-)\|<!>\|<:(\|>:>\|B)\|B-)\|X-(\|{\*}\|{1}\|{2}\|{3}\|{OK}\|{X}\|{da}\|{de}\|{en}\|{es}\|{fi}\|{fr}\|{it}\|{i}\|{ja}\|{ko}\|{nl}\|{o}\|{pt}\|{sv}\|{us}\|{zh}\||)\||-)\)\(\s\|\_$\)"
syn match   moinLinkMoin      "\([^!]\@<=\|^\)\<\(/\?\([[:upper:]][[:lower:][:digit:]]\+\)\{2,}\)\+\>"
syn match   moinLinkMoinBang  "!\ze\(/\?\([[:upper:]][[:lower:][:digit:]]\+\)\{2,}\)\+"
syn region  moinLinkExplicit  start="\[\[" end="\]\]"
syn region  moinLinkEmbedded  start="{{[^{]" end="}}"
syn match   moinLinkEmail     "<\?[[:alnum:]-._+]\+@[[:alnum:]-]\+\.[[:alnum:]-.]\+>\?"
syn match   moinLinkUrl       "\(http\|https\|ftp\|file\|mailto\|nntp\|news\|telnet\|irc\|ircs\|xmpp\|drawing\):\([^][:space:]<"'}|:,.)?!]\|[]"'}|:,.)?!][^][:space:]<"'}|:,.)?!]\)\+"
syn match   moinLinkInter     "[A-Z][a-zA-Z]\+:[^[:space:]'\":<]\([^][:space:]<"'}|:,.)?!]\|[]"'}|:,.)?!][^][:space:]<"'}|:,.)?!]\)\+"
syn cluster moinLinks         contains=moinLinkMoin,moinLinkExplicit,moinLinkEmbedded,moinLinkEmail,moinLinkUrl,moinLinkInter
syn cluster moinMarkup        contains=@moinTextMarkup,@moinLinks,moinMacro,moinStrike,moinSmileys
syn match   moinTableOpt      "<[^>]*>" contained
syn match   moinTableMark     "||\(<[^>]*>\)\?" contained contains=moinTableOpt
syn region  moinTable         start="^\s*||"rs=s end="||$"re=e oneline contains=moinTableMark,@moinMarkup
syn match   moinDefinition    "^\s\+.\{-}::\ze\(\s.*\)\?$"
syn match   moinList          "^\s\+\*\s"

if !exists("did_dic_syntax_inits")
  let did_dic_syntax_inits = 1
  hi link moinComment         Comment
  hi link moinInlineComment   Comment
  hi def  moinBold            term=bold cterm=bold gui=bold
  hi def  moinItalic          ctermfg=darkcyan gui=italic
  hi link moinUnderline       moinItalic
  hi link moinSub             moinItalic
  hi link moinSup             moinItalic
  hi def  moinSettings        ctermfg=green guifg=green
  hi def  moinPragma          ctermfg=darkred guifg=darkred
  hi link moinMacro           Macro
  hi def  moinStrike          ctermfg=darkgray guifg=darkgray
  hi link moinHeader          Title
  hi def  moinTableMark       ctermfg=yellow guifg=yellow
  hi def  moinTableOpt        ctermfg=darkyellow guifg=darkyellow
  hi link moinDefinition      moinBold
  hi link moinList            moinBold
  hi link moinRule            Title
  hi def  moinCode            ctermfg=cyan guifg=cyan
  hi def  moinLink            ctermfg=red guifg=red
  hi link moinLinkExplicit    moinLink
  hi link moinLinkEmbedded    moinLink
  hi link moinLinkMoin        moinLink
  hi link moinLinkMoinBang    moinLink
  hi link moinLinkEmail       moinLink
  hi link moinLinkUrl         moinLink
  hi link moinLinkBUrl        moinLinkUrl
  hi link moinLinkQUrl        moinLinkUrl
  hi link moinLinkInter       moinLink
  hi def  moinSmileys         ctermfg=yellow guifg=yellow
endif

let b:current_syntax = "moin"

