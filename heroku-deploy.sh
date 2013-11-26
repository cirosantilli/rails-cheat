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
first="false"
if [ ! -d .git ]; then
    git init
    first="true"
fi
git add .
git commit -am "deploy $(date "+%Y-%m-%d-%H-%M-%S")"
if $first; then
    heroku create "$appname"
fi
git push heroku master
heroku ps:scale web=1
heroku run rake setup
heroku open
