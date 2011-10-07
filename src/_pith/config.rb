require 'twitter'
require 'time-ago-in-words'

project.helpers do
  def tweets
    begin
      @tweets ||= Twitter.user_timeline("cogent_thoughts", :count => 10)
    end
  end

  def tweet(index=0)
    include("/_partials/_tweet.html.haml", :tweet => tweets[index]) if @tweets
  end
  
  def markup_links(tweet_text)
    tweet_text
  end
end