#! /bin/sh

source $HOME/.rvm/scripts/rvm
rvm use 1.9.2

export LANG; LANG=en_AU.UTF-8

set -e

bundle install
bundle exec rake "$@"
