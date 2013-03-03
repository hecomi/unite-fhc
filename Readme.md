unite-fhc : Unite source for Future Home Contoller
=============

Future Home Controller を操作する Unite source です。

Dependencies
-------------
+ Unite.vim  (https://github.com/Shougo/unite.vim)
+ webapi-vim (https://github.com/mattn/webapi-vim)

Install
-------------
```vim
" 遅延ロード
NeoBundleLazy 'hecomi/unite-fhc', {
\	'depends'  : ['mattn/webapi-vim'],
\	'autoload' : {
\		'unite_sources' : 'fhc',
\	},
\ }

" FHC の IP
let g:fhc_ip     = '192.168.0.11'
" FHC の Web API key
let g:fhc_apikey = 'webapi_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
```

Usage
-------------
```vim
:Unite fhc
```
