require 'twitter'
require 'time-ago-in-words'

project.helpers do
  def tweets
    @tweets ||= Twitter.user_timeline("cogent_thoughts", :count => 10)
  end

  def tweet(index=0)
    tweets.length > index ? include("/_partials/_tweet.html.haml", :tweet => tweets[index]) : ""
  end
  
  def markup_links(tweet_text)
    tweet_text
  end
end