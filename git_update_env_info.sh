#!/bin/sh

git filter-branch -f --env-filter '

an="$GIT_AUTHOR_NAME"
am="$GIT_AUTHOR_EMAIL"
cn="$GIT_COMMITTER_NAME"
cm="$GIT_COMMITTER_EMAIL"

if [ "$GIT_COMMITTER_EMAIL" = "l22k77@163.com" ]
then
    cn="kai.liu"
    cm="kai.liu@clinkway.com"
fi
if [ "$GIT_AUTHOR_EMAIL" = "l22k77@163.com" ]
then
    an="kai.liu"
    am="kai.liu@clinkway.com"
fi

export GIT_AUTHOR_NAME="$an"
export GIT_AUTHOR_EMAIL="$am"
export GIT_COMMITTER_NAME="$cn"
export GIT_COMMITTER_EMAIL="$cm"
'
