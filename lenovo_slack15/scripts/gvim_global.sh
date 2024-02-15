#!/bin/bash

# Current script exitsts only so for KDE Application menu entry.
# I have added their, an entry called gvim_global which
# calls current script, by absulute path: ~/tools/scripts/gvim_global.sh
# added using this link : <https://docs.kde.org/stable5/en/kmenuedit/kmenuedit/quickstart.html>

function g {
    if [ -z $(gvim --serverlist) ]; then
        gvim $@ >/dev/null 2>&1
    else
        [ $# -gt 0 ] \
		&& gvim --remote-silent $@ \
		|| gvim --remote-send ':sil call foreground()<CR>'
    fi
}

g $@
