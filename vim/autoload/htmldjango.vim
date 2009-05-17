function! htmldjango#CompleteTags(findstart, base)
    if a:findstart
        " locate the start of the word
        let start = col('.') - 1
        let curline = line('.')
        " Handling of <script> tag {{{
        let scriptstart = searchpair('{% block js %}', '', '{% endblock %}', "bnW")
        let scriptend   = searchpair('{% block js %}', '', '{% endblock %}', "nW")
        if scriptstart != 0 && scriptend != 0
            if scriptstart <= curline && scriptend >= curline
                let start = col('.') - 1
                let b:jscompl = 1
            endif
        endif
        " Handling of <style> tag {{{
        let scriptstart = searchpair('{% block css %}', '', '{% endblock %}', "bnW")
        let scriptend   = searchpair('{% block css %}', '', '{% endblock %}', "nW")
        if scriptstart != 0 && scriptend != 0
            if scriptstart <= curline && scriptend >= curline
                let start = col('.') - 1
                let b:csscompl = 1
            endif
        endif
        return htmlcomplete#CompleteTags(1, a:base)
    endif
    return htmlcomplete#CompleteTags(0, a:base)
endfunction
