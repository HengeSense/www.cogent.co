require "rubygems"
gem "bundler", ">= 1.0.0"
require "bundler"
Bundler.setup(:default)

require 'rspec/core'
require 'rspec/core/rake_task'

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)

task "default" => "watch"

require "rake/clean"
CLEAN << "src/_out"

desc "build the site"
task "build" do
  sh("pith -i src build")
end

desc "build the site, and rebuild incrementally when stuff changes"
task "watch" do
  sh("pith -i src watch")
end

desc "serve the site at http://localhost:4321, whilst rebuilding incrementally"
task "serve" do
  sh("pith -i src serve")
end

namespace "github" do

  desc "publish the site to GitHub Pages"
  task "publish" => ["update", "push"]

  task "update" do
    tmpdir = "/tmp/www.cogent.co"
    sh <<-BASH
      set -e -x
      rm -fr #{tmpdir}; pith -i src -o #{tmpdir} build
      git checkout gh-pages
      git fetch origin
      git reset --hard origin/gh-pages
      rm -r * && cp -r #{tmpdir}/* .
      rm -fr .sass-cache
      if git diff --exit-code > /dev/null; then
        echo "No change"
      else
        git add -A .
        git commit -m "Regenerate"
      fi
      git checkout master
    BASH
  end

  task "push" do
    sh "git push origin gh-pages:gh-pages"
  end

end
