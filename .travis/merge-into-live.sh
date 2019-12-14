#!/bin/bash

export GIT_COMMITTER_EMAIL="travis@travis"
export GIT_COMMITTER_NAME="Travis CI"

#git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* || exit
#git fetch --all || exit

temporaryDirectory1="$(mktemp -d)";
temporaryDirectory2="$(mktemp -d)";
cp -rT ./dist/ "$temporaryDirectory1/";
cd "$temporaryDirectory1";
rm .placeholder
cd "$temporaryDirectory2";
git clone --depth 10 https://github.com/ellipticcurv3/www.git .
git checkout live
cp -rT "$temporaryDirectory1/" "$temporaryDirectory2/"
git add --all
git commit -m "Travis CI $TRAVIS_COMMIT"
git push --set-upstream https://${GITHUB_TOKEN}@github.com/ellipticcurv3/www.git live
