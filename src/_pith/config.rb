require 'twitter'
require 'flickraw'

project.helpers do
  FlickRaw.api_key="8a82b5a4074ce3cea539edf10405aa0a"
  FlickRaw.shared_secret="11e0c00eb37d684b"
  def flickr_photo_in_set_url(owner, photo, set)
     "http://www.flickr.com/photos/#{owner}/#{photo}/in/set-#{set}/"
  end
  
  def project_photos(project, count=1)
    photoset_id = projects_yaml[project]['photoset_id']
    return [] unless photoset_id
    photoset = flickr.photosets.getPhotos(:photoset_id => photoset_id, :extras => ['title'], :per_page => count)
    photoset.photo.map do |p|
      { :url => FlickRaw.url(p), :caption => p.title, :set_url => flickr_photo_in_set_url(photoset.owner, p.id, photoset_id) } 
    end
  end
  
  def project_photo_html(photo_info)
    include('/_partials/_project_photo.html.haml', :photo => photo_info) if photo_info
  end
  
  def projects_html(count=nil, include_images=true)
    yaml = projects_yaml.values
    yaml = yaml.first(count) if count
    p count
    yaml.map do |project|
      include('/_partials/_project_summary.html.haml', :project => project, :include_images => include_images)
    end.join
  end
  
  def projects_yaml
    @project_yaml ||= YAML.load(File.read(File.expand_path(File.dirname(__FILE__) + '/projects.yml')))
  end
  
  def tweets
    @tweets ||= Twitter.list_timeline("dan_tropp", "cogent-team", :count => 10)
  end

  def tweet(offset=0)
    tweets.length > offset ? include("/_partials/_tweet.html.haml", :tweet => tweets[offset]) : ""
  end
  
  def markup_links(tweet_text)
    tweet_text
  end
end