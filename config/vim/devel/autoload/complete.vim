
function! complete#Auto_complete_string()
    if pumvisible()
        return "\<C-n>"
    else
        return "\<C-x>\<C-o>\<C-r>=complete#Auto_complete_opened()\<CR>"
    end
endfunction

function! complete#Auto_complete_opened()
    if pumvisible()
        return "\<Down>"
    end
    return ""
endfunction

