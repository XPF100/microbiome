#!/bin/bash
# See https://medium.com/@nthgergo/publishing-gh-pages-with-travis-ci-53a8270e87db

#set -o errexit # put back
#SOURCE_BRANCH="master"
#TARGET_BRANCH="gh-pages"
GH_REPO="@github.com/microbiome/microbiome.git"
FULL_REPO="https://$GH_TOKEN$GH_REPO"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
#if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
#    echo "Skipping deploy; just doing a build."
#    doCompile
#    exit 0
#fi

# Save some useful information
#REPO=`git config remote.origin.url`
#SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
#SHA=`git rev-parse --verify HEAD`

rm -rf public # ; || exit 0;
mkdir public

# config
git config --global user.email "nobody@nobody.org"
git config --global user.name "Travis CI"

# build (CHANGE THIS)
# Can add separate vignette build here later
#function doCompile {
#  ./compile.sh
#}
# Run our compile script -> Add this to a suitable place
# doCompile

# Add
#for files in '*.tar.gz'; do
#        tar xfz $files
#done

# Deploy
cd public
git init

#cp ../microbiome/inst/doc/vignette.html index.html
#cp ../microbiome/vignettes/vignette.html index.html
# Add when index works
#for files in '../microbiome/inst/doc/*.html'; do
for files in '../microbiome/vignettes/*.html'; do    
        cp $files .
done

#touch index.html
ls ../ > index.html
git add *.html
git commit -a -m "Deploy to Github Pages"
git push --force --quiet $FULL_REPO master:gh-pages # > /dev/null 2>&1
