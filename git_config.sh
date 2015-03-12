#!/bin/bash

#set name
git config --global user.name kai.liu

#set email
git config --global user.email kai.liu@clinkway.com

#set alias
git config alias.co checkout
git config alias.br branch

#diff ignore ^M
git config --global core.whitespace cr-at-eol

#set git diff/status color
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto
