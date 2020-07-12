#!/bin/sh
# TODO try to detect this remote before we just go ahead and add a new one
git remote add helpwithblackequity https://git.heroku.com/helpwithblackequity.git
git push helpwithblackequity helpwithblackequity:master
