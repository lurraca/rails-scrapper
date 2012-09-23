require 'rubygems'
require 'mechanize'
require 'to_regexp'
class Crawler
  def initialize(url,keywords,quantity_to_match)
    @url = url
    @keywords = keywords
    @quantity_to_match =  quantity_to_match
    @isBusiness = false
    @isActive
  end

  def crawl  #Method will accept URL and Keywords will check each link agaisnt the keyword to detect if business
    match_count = 0
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
        regexp = str.to_regexp
        if regexp.match(link.uri.to_s).nil?
        #if /thegame/.match(link.uri.to_s).nil?
          puts link.uri
        else
          match_count += 1
          puts match_count
        end
      end
    end
    puts @quantity_to_match
    puts match_count
    @isBusiness = true if match_count >= @quantity_to_match
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
