#!/bin/bash

#set name
git config user.name eagle
git config --global user.name aaaaa 

#set email
git config user.email l22k77@163.com
git config --global user.email aaaaa@company.com

#set default editor
git config --global core.editor vim

#set alias
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.br "branch -a"
git config --global alias.cm commit
git config --global alias.df diff

#diff ignore ^M
git config --global core.whitespace cr-at-eol

#set git diff/status color
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto
