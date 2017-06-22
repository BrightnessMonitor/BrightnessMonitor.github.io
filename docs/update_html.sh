#!/bin/bash

# build the new html files
make html

# rm the old html files
rm -r ../_sources
rm -r ../_static
rm ../*.html
rm ../objects.inv
rm ../*.js

# copy the html files to the root folder
cp -r build/html/* ../
cp -r build/html/.[^.]* ../

# add files to gitgit push
git add -A