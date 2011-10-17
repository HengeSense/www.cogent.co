require 'time'
require 'twitter'
require 'flickraw'
require File.expand_path(File.dirname(__FILE__) + '/../../lib/yaml_config.rb')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/twitter_feed.rb')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/flickr_feed.rb')

require 'tilt'

class CustomScssTemplate < Tilt::ScssTemplate

  private

  def sass_options
    options.merge(:filename => eval_file, :line => line, :syntax => :scss, :style => :compact)
  end

end

Tilt.register CustomScssTemplate, 'scss'

# Generate shorter URLs
project.assume_content_negotiation = true
project.assume_directory_index = true

project.helpers do
  include YamlConfig
  include TwitterFeed
  include FlickrFeed

  def ignore_feed_errors?
    ENV['RUBY_ENV'] != 'tolerant'
  end

  def project_quote_html(offset)
    quote = project_yaml['quotes'][offset]
    include('/_partials/_project_quote.html.haml', :quote => quote) if quote
  end

  def project_photo_html(photo_info)
    include('/_partials/_project_photo.html.haml', :photo => photo_info) if photo_info
  end

  def project_html(project, photo)
    include('/_partials/_project_summary.html.haml', :project => project, :project_photo => photo)
  end

  def person_html(index)
    person = people_yaml[index]
    if person
      photo = person_photo(person)
      include('_partials/_people.html.haml', :person => person, :photo => photo) if photo
    end
  end

  def tweet_html(tweet)
    include("/_partials/_tweet.html.haml", :tweet => tweet)
  end

  def absolute_current_path
    path = page.output_path.to_s
    path.sub!(/index\.html$/, "") if project.assume_directory_index
    path.sub!(/\.html$/, "") if project.assume_content_negotiation
    "/" + path
  end

  def nav_link(path, label)
    puts "does #{path.inspect} == #{absolute_current_path.inspect}"
    selected = (path == absolute_current_path)
    unless path == "/"
      selected ||= absolute_current_path.start_with?(path)
    end
    %{<a href="#{path}" class="#{'selected' if selected}">#{label}</a>}
  end

end
