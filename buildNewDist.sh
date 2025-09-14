#!/bin/bash

if [ $# -gt 1 ]; then
  echo "ERROR: Too many arguments have been passed!"
  exit 1
fi

if [ -z $1 ]
then
	echo "ERROR: Write a commit message!"
    exit 1
fi

#npm run build
git add .
git commit -m "$1"
#git subtree push --prefix dist origin gh-pages
git push