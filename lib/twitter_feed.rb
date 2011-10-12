module TwitterFeed
  def twitter_url(twitter_id)
    "http://twitter.com/#!/#{twitter_id}"
  end
  
  def tweets
    begin
      @tweets ||= Twitter.list_timeline("dan_tropp", "cogent-team", :count => 10)
    rescue Exception => ex
      if ignore_feed_errors?
        raise ex
      else
        @tweets = []
      end
    end
  end

  def tweet(offset=0)
    tweets.length > offset ? tweet_html(tweets[offset]) : ""
  end
  
  def markup_links(tweet_text)
    tweet_text
  end
end