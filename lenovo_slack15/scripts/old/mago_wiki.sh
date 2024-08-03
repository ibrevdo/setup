
#!/bin/bash


vim_edit_bookmark() {
	vim $(echo $1  | sed "s|file:///home/mago/|$HOME/|" )
}

open_wiki_browse() {
chromium-ungoogled --new-window					\
		~/igorba/git/wiki/.html/home.html
}

if [[ $# -gt 0 ]]; then
	case $1 in
	-e)
		vim_edit_bookmark $2
		;;
	-h)
		printf "Usage: mago_wiki.sh [options] <link>
mago_wiki.sh               open browser with wiki tabs
mago_wiki.sh -e <link>     open vim with specified file
mago_wiki.sh -h            print this help\n"
		;;
	esac
else
	open_wiki_browse
fi

