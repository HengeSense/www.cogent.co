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

  # Duplicate functionality which twitter JS does to tweet text  
  # for (var i=0; i<twitters.length; i++){
  #   var username = twitters[i].user.screen_name;
  #   var status = twitters[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
  #     return '<a href="'+url+'">'+url+'</a>';
  #   }).replace(/\B@([_a-z0-9]+)/ig, function(reply) {
  #     return  reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'">'+reply.substring(1)+'</a>';
  #   });
  #   statusHTML.push('<li><span>'+status+'</span> <a style="font-size:85%" href="http://twitter.com/'+username+'/statuses/'+twitters[i].id_str+'">'+relative_time(twitters[i].created_at)+'</a></li>');
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