syn match diffRemoved	"\%(^#\)\@<=-.*" contained containedin=gitcommitComment 
syn match diffRemoved	"\%(^#\)\@<=<.*" contained containedin=gitcommitComment 
syn match diffAdded	"\%(^#\)\@<=+.*" contained containedin=gitcommitComment 
syn match diffAdded	"\%(^#\)\@<=>.*" contained containedin=gitcommitComment 
syn match diffChanged	"\%(^#\)\@<=! .*" contained containedin=gitcommitComment 

syn match diffSubname	" @@..*"ms=s+3 contained
syn match diffLine	"\%(^#\)\@<=@.*" contains=diffSubname contained containedin=gitcommitComment 
syn match diffLine	"\%(^#\)\@<=\<\d\+\>.*" contained containedin=gitcommitComment 
syn match diffLine	"\%(^#\)\@<=\*\*\*\*.*" contained containedin=gitcommitComment 
syn match diffLine	"\%(^#\)\@<=---$" contained containedin=gitcommitComment 

"Some versions of diff have lines like "#c#" and "#d#" (where # is a number)
syn match diffLine	"\%(^#\)\@<=\d\+\(,\d\+\)\=[cda]\d\+\>.*" contained containedin=gitcommitComment 

syn match diffFile	"\%(^#\)\@<=diff.*" contained containedin=gitcommitComment 
syn match diffFile	"\%(^#\)\@<=+++ .*" contained containedin=gitcommitComment 
syn match diffFile	"\%(^#\)\@<=Index: .*$" contained containedin=gitcommitComment 
syn match diffFile	"\%(^#\)\@<===== .*$" contained containedin=gitcommitComment 
syn match diffOldFile	"\%(^#\)\@<=\*\*\* .*" contained containedin=gitcommitComment 
syn match diffNewFile	"\%(^#\)\@<=--- .*" contained containedin=gitcommitComment 
