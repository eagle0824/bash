#! /bin/bash

git filter-branch --env-filter '

oldEmail="kai.liu@imotorinfo.com"
newName="eagle"
newEmail="l22k77@163.com"

if [ "$GIT_COMMITTER_EMAIL" = "$oldEmail" ]; then
    export GIT_COMMITTER_NAME="$newName"
    export GIT_COMMITTER_EMAIL="$newEmail"
fi

if [ "$GIT_AUTHOR_EMAIL" = "$oldEmail" ]; then
    export GIT_AUTHOR_NAME="$newName"
    export GIT_AUTHOR_EMAIL="$newEmail"
fi

' --tag-name-filter cat -- --branches --tags
