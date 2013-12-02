#!/usr/bin/env bash

# Generates a current deploy version of the app for Heroku
# and deploys it.

# If a deploy version already exists, only updates it to match the tree.

# You must have:
#
# - a heroku account,
# - the `heroku` command installed
# - run `heroku login` at least once.

set -u
set -e

if [ $# -gt 0 ]; then
    appname="$1"
    shift
else
    appname=""
fi

if [ $# -gt 0 ]; then
    echo "too many arguments" 1>&2
    #usage
    exit 2
fi

dest="heroku.tmp"
mkdir -p "$dest"
cp -fru -t "$dest" app/* app/.[^.]* #app/..?*
cd "$dest"
sed -ri 's/.*smtp_settings\.rb.*//' .gitignore
echo "gem 'pg'" > Gemfile_dbms
bundle install
echo "
development:
  adapter: postgresql
  encoding: unicode
  database: myapp_development
  pool: 5
  password:
" > config/database.yml
if [ ! -d .git ]; then
    git init
    if [ -z "$appname" ]; then
        heroku create
    else
        heroku create "$appname"
    fi
    # Set this environment variable to tell the app that we are on heroku.
    heroku config:set HEROKU=true
fi
git add .
git commit -am "deploy $(date "+%Y-%m-%d-%H-%M-%S")"
git push heroku master
heroku run rake setup
heroku ps:scale web=1
heroku open
