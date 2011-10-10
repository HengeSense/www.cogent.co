#! /bin/sh

source $HOME/.rvm/scripts/rvm
rvm use 1.9.2

set -e

bundle install
bundle exec rake "$@"
