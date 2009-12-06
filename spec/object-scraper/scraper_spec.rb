require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Scraper do
  before :all do
    @uri     = File.expand_path(File.join(File.dirname(__FILE__), '..', 'data', 'twitter.html' ))
    @pattern = ".status"
    class Entry < Object
      attr_accessor :text, :date
    end
  end
  
  describe "defining a scraper" do
    
    it "should create a new scraper using the specified name" do
      Scraper.define(:spec_1, :class => :entry, :source => @uri, :node => @pattern) {}

      Scraper(:spec_1).scraper_source.should == @uri
    end

    it "should be set with and without block" do
      Scraper.define(:spec_2, :class => :entry, :source => @uri, :node => @pattern) do |s|
        s.text "foo"
        s.date {"bar"}
      end

      @objects = Scraper.parse(:spec_2)
      @objects.first.text.should == "foo"
      @objects.first.date.should == "bar"
    end
    
    it "should get the objects from twitter" do
      Scraper.define(:twitter, :class => :entry, :source => @uri, :node => @pattern) do |s|
        s.text { |node| node.at(".entry-content").inner_html }
        s.date { |node| DateTime.parse(node.at(".timestamp")[:data][/\'.*\'/].gsub("'", "")) }
      end
      
      @objects = Scraper.parse(:twitter)
      @objects.size.should == 20
      @objects.first.text.should == "SMS delivery issues on AT&T <a href=\"http://bit.ly/7JFJ6H\" class=\"tweet-url web\" rel=\"nofollow\" target=\"_blank\">http://bit.ly/7JFJ6H</a>"
      @objects.first.date.should == DateTime.parse("Mon Nov 30 04:10:51 +0000 2009")
    end
  end
end