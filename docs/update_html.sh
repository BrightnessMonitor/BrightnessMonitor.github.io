#!/bin/bash

# build the new html files
make html

# rm the old html files
rm -r ../_sources
rm -r ../_static
rm ../.buildinfo
rm ../.nojekyll
rm ../genindex.html
rm ../index.html
rm ../objects.inv
rm ../search.html
rm ../searchindex.js

# copy the html files to the root folder
cp -r build/html/* ../