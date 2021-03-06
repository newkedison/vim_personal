" Last Change: 2010-06-25 11:26:33
if !exists('loaded_snippet') || &cp
    finish
endif

function! Count(haystack, needle)
    let counter = 0
    let index = match(a:haystack, a:needle)
    while index > -1
        let counter = counter + 1
        let index = match(a:haystack, a:needle, index+1)
    endwhile
    return counter
endfunction

function! CArgList(count)
    " This returns a list of empty tags to be used as 
    " argument list placeholders for the call to printf
    let st = g:snip_start_tag
    let et = g:snip_end_tag
    if a:count == 0
        return ""
    else
        return repeat(', '.st.et, a:count)
    endif
endfunction
	
function! CMacroName(filename)
    let name = a:filename
    let name = substitute(name, '\.','_','g')
    let name = substitute(name, '\(.\)','\u\1','g')
    return name
endfunction

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet do do<CR>{<CR>".st.et."<CR>} while ();"
exec "Snippet readfile std::vector<uint8_t> v;<CR>if(FILE* fp = fopen(\"".st."filename".et."\", \"r\"))<CR>{<CR>uint8_t buf[1024];<CR>while(size_t len = fread(buf, 1, sizeof(buf), fp))<CR>v.insert(v.end(), buf, buf + len);<CR>fclose(fp);<CR>}<CR>"
exec "Snippet beginend ".st."v".et.".begin(), ".st."v".et.".end()"
exec "Snippet once #ifndef ``CMacroName(expand('%'))``_<CR><CR>#define ``CMacroName(expand('%'))``_<CR><CR>".st.et."<CR><CR>#endif /* ``CMacroName(expand('%'))``_ */<CR>"
exec "Snippet class class ".st."name".et."<CR>{<CR>public:<CR>".st."name".et." (".st."arguments".et.");<CR>virtual ~".st."name".et."();<CR><CR>private:<CR>".st.et."<CR>};<CR>"
" TODO This is a good one but I can't quite work out the syntax yet
exec "Snippet printf printf(\"".st."\"%s\"".et."\\n\"".st."\"%s\":CArgList(Count(@z, '%[^%]'))".et.");<CR>"
exec "Snippet vector std::vector<".st."char".et."> v".st.et.";"
exec "Snippet struct struct ".st."name".et."<CR>{<CR>".st.et."<CR>};<CR>"
exec "Snippet template template <typename ".st."_InputIter".et."><CR>"
" TODO this one as well. Wish I knew more C
" Snippet namespace namespace ${1:${TM_FILENAME/(.*?)\\..*/\\L$1/}}\n{\n\t$0\n};<CR>
exec "Snippet namespace namespace ".st.":substitute(expand('%'),'.','\\l&', 'g')".et."<CR>{<CR>".st.et."<CR>};<CR>"
exec "Snippet map std::map<".st."key".et.", ".st."value".et."> map".st.et.";<CR>"
exec "Snippet mark #if 0<CR><CR>".st.et."<CR><CR>#endif<CR><CR>"
exec "Snippet if if(".st.et.")<CR>{<CR><CR>}"
exec "Snippet main int main (int argc, char const* argv[])<CR>{<CR>".st.et.";<CR>return 0;<CR>}<CR>"
exec "Snippet Inc #include <".st.et."><CR>"
exec "Snippet inc #include \"".st.et.".h\""
exec "Snippet for for( ".st.et." ".st."i".et." = 0; ".st."i".et." < ".st.et."; ++".st."i".et.")<CR>{<CR><CR>}"
exec "Snippet fo for(".st."i".et." = 0; ".st."i".et." < ".st.et."; ++".st."i".et.")<CR>{<CR><CR>}"
