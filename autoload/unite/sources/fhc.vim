scriptencoding utf-8

let g:fhc = {}

function! g:fhc.get_json(kind, opt)
	let l:opt = ''
	for key in keys(a:opt)
		let l:opt .= '&'.key.'='.a:opt[key]
	endfor
	let l:fhc_url = 'http://'.g:fhc_ip.'/api/'.a:kind.'?webapi_apikey='.g:fhc_apikey.l:opt
	let l:res     = webapi#http#get(l:fhc_url)
	if l:res.content == ''
		return {'result': 'error', 'code': 'xxx', 'message': 'network error'}
	endif
	let l:json    = webapi#json#decode(l:res.content)
	return l:json
endfunction

function! g:fhc.check_err(json)
	if a:json.result != 'ok'
		cexpr a:json.code . ': ' . a:json.message
		return -1
	endif
	return 0
endfunction

function! g:fhc.get_list()
	let l:json = self.get_json('recong/list', {})
	if self.check_err(l:json) != 0
		return []
	endif
	let l:kaden_list = l:json.list
	return l:kaden_list
endfunction

function! g:fhc.firebystring(str)
	let l:json = self.get_json('recong/firebystring', {'str': a:str})
	if !self.check_err(l:json) != 0
		return
	endif
endfunction

let s:source = {
\	'name'        : 'fhc',
\	'description' : 'exec future home controller commands',
\ }
call unite#define_source(s:source)

function! s:source.gather_candidates(args, context)
	let l:command = 'call g:fhc.firebystring("%s")'
	return map(
	\ g:fhc.get_list(),
	\ '{
	\	"word"            : v:val,
	\	"source"          : "fhc",
	\	"kind"            : "command",
	\	"action__command" : printf(l:command, v:val),
	\ }')
endfunction

function! unite#sources#fhc#define()
	return s:source
endfunction

