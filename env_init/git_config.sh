#!/bin/bash

echo "git config..............................start"
#please use your name and email config this sh
sudo apt-get install git git-core

#set name
git config --global user.name kai.liu_pc

#set email
git config --global user.email kai.liu@imotorinfo.com

#set default editor
git config --global core.editor vim

#git diff的时候忽略换行符的差异
git config --global core.whitespace cr-at-eol

#git status改善中文文件时乱码显示
git config --global core.quotepath false

#不自动转换文件换行符：windows下默认是\r\n，linux下是\n
git config --global core.autocrlf false

#set alias
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.br "branch -a"
git config --global alias.cm "commit -s"
git config --global alias.df diff

#set git diff/status color
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto

echo "git config..............................end"
