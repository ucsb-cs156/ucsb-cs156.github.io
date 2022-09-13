#!/bin/sh

rm -rf _site
bundle exec jekyll build
open http://localhost:4000 & 
bundle exec jekyll serve
