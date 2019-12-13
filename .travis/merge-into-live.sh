#!/bin/bash

export GIT_COMMITTER_EMAIL="travis@travis"
export GIT_COMMITTER_NAME="Travis CI"

git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* || exit
git fetch --all || exit

temporaryDirectory="$(mktemp -d)";
cp -r ./dist/ "$temporaryDirectory/";


git checkout --orphan live || exit
git rm --cached -r .
rm -r ./*
cp -rT "$temporaryDirectory/dist/" ./
git add --all
git commit -m "Travis CI $TRAVIS_COMMIT"
git push

#git push https://${GITHUB_TOKEN}@github.com/ellipticcurv3/www.git
