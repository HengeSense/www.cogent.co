require 'twitter'
require 'time-ago-in-words'

project.helpers do
  def markup_links(tweet_text)
    tweet_text
  end
  # function twitterCallback2(twitters) {
  #   var statusHTML = [];
  #   for (var i=0; i<twitters.length; i++){
  #     var username = twitters[i].user.screen_name;
  #     var status = twitters[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
  #       return '<a href="'+url+'">'+url+'</a>';
  #     }).replace(/\B@([_a-z0-9]+)/ig, function(reply) {
  #       return  reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'">'+reply.substring(1)+'</a>';
  #     });
  #     statusHTML.push('<li><span>'+status+'</span> <a style="font-size:85%" href="http://twitter.com/'+username+'/statuses/'+twitters[i].id_str+'">'+relative_time(twitters[i].created_at)+'</a></li>');
  #   }
  #   document.getElementById('twitter_update_list').innerHTML = statusHTML.join('');
  # }
end