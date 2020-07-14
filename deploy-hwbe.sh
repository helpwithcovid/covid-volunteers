#!/bin/sh
# Creates a 'helpwithblackequity' remote if you don't have one
heroku git:remote --app helpwithblackequity -r helpwithblackequity
git push helpwithblackequity refactor/themable-app:master
