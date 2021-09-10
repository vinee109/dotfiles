" Set syntax strategies
au! Syntax thrift source ~/.vim/ftplugin/thrift.vim
au! Syntax hive source ~/.vim/ftplugin/hive.vim

" Define different extensions to follow a particlar file type
au BufNewFile,BufRead *.hql setlocal filetype=hive expandtab
au BufNewFile,BufRead *.ddl setlocal filetype=hive expandtab
au BufNewFile,BufRead *.thrift setlocal filetype=thrift
