if exists('b:mapped_html_functions')
	fini
en
let b:mapped_html_functions = 1

ino <buffer> < <c-r>=<SID>OpenPair('<', '>')<cr>
ino <silent> <buffer> <bs> <c-r>=<SID>RemovePair()<cr>
ino <buffer> <silent> > <c-r>=<SID>CloseTag()<cr>
ino <buffer> <silent> <cr> <c-r>=<SID>Return()<cr>
nm <buffer> <s-t> vE<s-t>
vno <buffer> <silent> <s-t> :<c-u>cal <SID>TagWrapper()<cr>

if exists('s:loaded_html_functions')
	fini
en
let s:loaded_html_functions = 1

fun s:OpenPair(char, char2)
	" Don't autocomplete in a string
	if getline('.')[col('.') - 1] =~ '\w'
		retu a:char
	el
		retu a:char.a:char2."\<left>"
	en
endf

" automatically remove the entire autocompletion when the opening character
" is deleted & there are no characters in between
fun s:RemovePair()
	let line = getline('.')
	let col = col('.') - 1
	let chars = line[col - 1].line[col]

 	if chars =~ '\(()\|{}\|\[\]\|<>\|""\|''''\)'
		retu "\<right>\<bs>\<bs>"
	el
		retu "\<bs>"
	en
endf

fun s:TagWrapper()
	let a:tag = input("Wrap in tag: ")
	exe 'norm! `>a</'.a:tag.'>'
	exe 'norm! `<i<'.a:tag.'>'
endf

" Cleanly return after autocompleting an html/xml tag
fun s:Return()
	let line = getline('.')
	let col = col('.')
	if line[col - 1] == '<' && line[col - 2] == '>'
		retu "\<cr>\<cr>\<up>"
	en
	retu "\<cr>"
endf

" automatically inserts closing tag after starting tag
fun s:CloseTag()
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == '/'
		retu "\<right>"
	elsei line[col - 1] == '>'
		let col += 1
		cal cursor(('.'), col)
		" don't autocomplete next to a word or another tag or if inside comment
		if line[col] !~ '\(\w\|<\|>\)' && synIDattr(synID(line('.'),col-1, 0),'name') !~ 'omment'
			let tag = matchstr(matchstr(line, '<\(\w\|=\| \|''\|"\)*>\%'.col.'c'), '<\a*')
			" insert closing tag if tag is not self-closing
			if tag != '' && tag !~ '<\(img\|input\|link\|meta\|br\|hr\|area\|base\|param\|dd\|dt\)'
				exe 's/\%'.col.'c/'.escape(substitute(tag, '^<', '</', ''), '/').'>'
				cal cursor(('.'), col)
			en
		en
		retu ''
	en
	retu '>'
endf
