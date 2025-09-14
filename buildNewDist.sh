#!/bin/bash

if [ $# -gt 1 ]; then
  echo "ERROR: Too many arguments have been passed!"
  exit 1
fi

if [ -z "$1" ]
then
	echo "ERROR: Write a commit message!"
    exit 1
fi

# Build dist and add its changes to gh-pages branch
npm run build
git add dist -f
git commit -m "$1"
git subtree push --prefix dist origin gh-pages

# Update master branch with file changes
git push