require File.expand_path(File.dirname(__FILE__) + '/../lib/twitter_feed.rb')

class TestTwitterFeed
  include TwitterFeed
end

describe TestTwitterFeed do
  describe "#markup_links" do
    it "marks up an http link" do
      subject.markup_links("This is cool http://t.co/jdsd347d").should == 'This is cool <a href="http://t.co/jdsd347d">http://t.co/jdsd347d</a>'
    end

    it "marks up a mentioned twitter user" do
      subject.markup_links("This is cooler than @dantropp").should == 'This is cooler than @<a href="http://twitter.com/dantropp">dantropp</a>'
    end
  end
end