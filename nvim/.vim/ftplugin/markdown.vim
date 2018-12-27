" Vim Filetype Plugin File
" Language: markdown
" Extensions: *.md

"""""""""""" Line Width
set tw=80

"""""""""""" Custom Commands
" usage :Preview - automatically renders current file to html and opens in
" browser
command Preview w | !pandoc -f markdown -o /tmp/output.html %:t && open /tmp/output.html
