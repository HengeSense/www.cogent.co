require 'twitter'

project.helpers do
  def projects_html(count=nil, include_images=true)
    yaml = projects_yaml
    yaml = yaml.first(count) if count
    p count
    yaml.map do |project|
      include('/_partials/_project_summary.html.haml', :project => project, :include_images => include_images)
    end.join
  end
  
  def projects_yaml
    YAML.load(File.read(File.expand_path(File.dirname(__FILE__) + '/projects.yml')))
  end
  
  def tweets
    @tweets ||= Twitter.list_timeline("dan_tropp", "cogent-team", :count => 10)
  end

  def tweet(index=0)
    tweets.length > index ? include("/_partials/_tweet.html.haml", :tweet => tweets[index]) : ""
  end
  
  def markup_links(tweet_text)
    tweet_text
  end
end