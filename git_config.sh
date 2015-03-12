#!/bin/bash

#set name
git config --global user.name kai.liu

#set email
git config --global user.email kai.liu@clinkway.com

#set default editor
git config --global core.editor vim

#set alias
git config alias.co checkout 
git config alias.st status
git config alias.br "branch -a"
git config alias.ct commit
git config alias.df diff

#diff ignore ^M
git config --global core.whitespace cr-at-eol

#set git diff/status color
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto
