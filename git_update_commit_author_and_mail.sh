#!/bin/bash
git filter-branch -f --env-filter "GIT_AUTHOR_NAME='eagle'; GIT_AUTHOR_EMAIL='l22k77@163.com'; GIT_COMMITTER_NAME='eagle'; GIT_COMMITTER_EMAIL='l22k77@163.com';"
