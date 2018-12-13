#!/bin/sh

echo "=================start build==================="
gitbook build >> /dev/null

echo "=================clean files==================="
git checkout gh-pages
git rm --cached -r . >> /dev/null
git clean -df >> /dev/null

echo "*~" > .gitignore
echo "_book" >> .gitignore

echo "================copy static file and commit ==============="
cp -r _book/* .
rm -rf deploy.sh
git add .
git commit -m "publish book"
git push origin gh-pages:gh-pages

git checkout master
echo "=================success!!!====================="





