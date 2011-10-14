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
    linked_text = tweet_text.gsub(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/) do |url| 
      %{<a href="#{url}">#{url}</a>}
    end
    linked_text = linked_text.gsub(/\B@([_a-z0-9]+)/i) do |user| 
      username = user.slice(1..-1)
      %{@<a href="http://twitter.com/#{username}">#{username}</a>}
    end
    linked_text
  end

end