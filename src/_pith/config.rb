require 'twitter'
require 'flickraw'

project.helpers do
  FlickRaw.api_key="8a82b5a4074ce3cea539edf10405aa0a"
  FlickRaw.shared_secret="11e0c00eb37d684b"
    
  def twitter_url(twitter_id)
    "http://twitter.com/#!/#{twitter_id}"
  end
  
  def flickr_photo_in_set_url(owner, photo, set)
     "http://www.flickr.com/photos/#{owner}/#{photo}/in/set-#{set}/"
  end
  
  def production?
    ENV['RUBY_ENV'] != 'development'
  end
  
  def project_quote_html(project, offset)
    quote = project_yaml(project)['quotes'][offset]
    include('/_partials/_project_quote.html.haml', :quote => quote) if quote
  end

  def photos_in_set(photoset_id, count=nil)
    begin
      params = {:photoset_id => photoset_id, :extras => ['title']}
      params[:per_page] = count if count
      photoset = flickr.photosets.getPhotos(params)
      photoset.photo.map do |p|
        { :id => p.id, :url => FlickRaw.url(p), :caption => p.title, :set_url => flickr_photo_in_set_url(photoset.owner, p.id, photoset_id) } 
      end
    rescue Exception => ex
      if production?
        raise ex
      else
        []
      end
    end
  end
  
  def people_photos
    photos_in_set(72157627741365001)
  end
  
  def project_photos(project, count=1)
    photoset_id = project_yaml(project)['photoset_id']
    return [] unless photoset_id
    photos_in_set(photoset_id, count)
  end
  
  def project_photo_html(photo_info)
    include('/_partials/_project_photo.html.haml', :photo => photo_info) if photo_info
  end
  
  def projects_html(count=nil, include_images=true)
    yaml = projects_yaml
    yaml = yaml.first(count) if count
    yaml.map do |project|
      include('/_partials/_project_summary.html.haml', :project => project, :include_images => include_images)
    end.join
  end
  
  def person_html(person, photo)
    include('_partials/_people.html.haml', :person => person, :photo => photo) if person and photo
  end
  
  def project_yaml(project_name)
    projects_yaml.find {|p| p['name'] == project_name }
  end
  
  def load_yaml(filename)
    YAML.load(File.read(File.expand_path(File.dirname(__FILE__) + '/' + filename)))
  end
  
  def projects_yaml
    @project_yaml ||= load_yaml('projects.yml')
  end
  
  def people_yaml
    @people_yaml ||= load_yaml('people.yml')
  end
  
  def tweets
    begin
      @tweets ||= Twitter.list_timeline("dan_tropp", "cogent-team", :count => 10)
    rescue Exception => ex
      if production?
        raise ex
      else
        @tweets = []
      end
    end
  end

  def tweet(offset=0)
    tweets.length > offset ? include("/_partials/_tweet.html.haml", :tweet => tweets[offset]) : ""
  end
  
  def markup_links(tweet_text)
    tweet_text
  end
end