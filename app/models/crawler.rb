require 'rubygems'
require 'mechanize'
require 'to_regexp'
class Crawler
  attr_reader :matched_keywords, :quantity_to_match
  def initialize(url,keywords,quantity_to_match)
    @url = url
    @title = title
    @keywords = keywords
    @matched_keywords = Hash.new
    @quantity_to_match =  quantity_to_match
    @isBusiness = false
    @isActive
  end

  def crawl  #Method will accept URL and Keywords will check each link agaisnt the keyword to detect if business
    agent = Mechanize.new
    agent.log = Logger.new('out.log')
    agent.user_agent_alias = 'Mac Safari'
    begin
      page = agent.get(@url)
    #rescue Mechanize::ResponseCodeError => exception
    rescue StandardError
      #if exception.response_code == '400' or exception.response_code == '500'
        @isActive = false
        return
      #end
    end
    @isActive = true
    @title = page.title
    page.links.each do |link| #For every link in the page
      @keywords.each do |keyword| #For every keyword provided
        str = "/"+keyword.to_s+"/" #Turn keyword into regexp
        regexp = str.to_regexp
        if regexp.match(link.uri.to_s).nil? and regexp.match(link.text).nil?
          puts link.uri
          puts link.text
        else
          @matched_keywords[keyword] = link #HASH of matched keywords
        end
      end
    end
    @isBusiness = true if @matched_keywords.values.uniq.count >= @quantity_to_match
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

  def matched_keywords
    @matched_keywords
  end
  def title
    @title
  end
end
