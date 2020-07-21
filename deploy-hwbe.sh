#!/bin/sh
# Creates a 'helpwithblackequity' remote if you don't have one
heroku git:remote --app helpwithblackequity -r helpwithblackequity
git push helpwithblackequity helpwithblackequity:master
curl -s -i https://helpwithblackequity.herokuapp.com | head -n1
