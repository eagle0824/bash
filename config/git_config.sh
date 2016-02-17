#!/bin/bash

#please use your name and email config this sh

#set name
git config --global user.name name

#set email
git config --global user.email email

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
