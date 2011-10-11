require File.expand_path(File.dirname(__FILE__) + '/../lib/twitter_feed.rb')

class TestTwitterFeed
  include TwitterFeed
end

describe TwitterFeed do
  describe "#markup_links" do
    it "returns same text" do
      subject.markup_links("dan").should == 'dan'
    end
  end
end