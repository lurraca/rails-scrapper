require 'rubygems'
require 'mechanize'
class Crawler
  def initialize(url,keywords)
    @url = url
    @keywords = keywords
    @isBusiness = false
    @isActive
  end

  def crawl  #Method will accept URL and Keywords will check each link agaisnt the keyword to detect if business
    agent = Mechanize.new
    begin
      page = agent.get(@url)
    rescue Mechanize::ResponseCodeError => exception
      if exception.response_code == '400'
        @isActive = false
        return
      end
    end
    @isActive = true
    page.links.each do |link| #For every link in the page
      @keywords.each do |keyword| #For every keyword provided
        str = "/"+keyword.to_s+"/" #Turn keyword into regexp
        regexp = Regexp.new str
        if regexp.match(link.uri.to_s).nil?
          puts link.uri
        else
          @isBusiness = true
        end
      end
    end
  end

  def isBusiness
    @isBusiness
  end

  def url
    @url
  end

  def keywords
    @keywords
  end

  def isActive
    @isActive
  end
end
