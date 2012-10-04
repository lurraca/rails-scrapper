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
    def domain_name?(url)
      #domain_regex = /^((http|https):\/\/)[a-z0-9]*(\.?[a-z0-9]+)\.[a-z]{2,5}(:[0-9]{1,5})?(\/.)?$/ix
      domain_regex = /^https?:\/\//
      if !domain_regex.match(url).nil?
        status = true
      else
        @url = 'http://'+url
        status = false
      end
      if !domain_regex.match(@url).nil?
        status = true
      else
        status = false
      end
      status
    end

  def crawl  #Method will accept URL and Keywords will check each link agaisnt the keyword to detect if business
    if domain_name?(@url)
      agent = Mechanize.new
      agent.max_history=1
      agent.read_timeout=4
      agent.open_timeout=4
      agent.log = Logger.new "mmech.log"
      agent.user_agent_alias = 'Mac Safari'
      begin
        page = agent.get(@url)
        puts page.content_type
        if /html/.match(page.content_type).nil?
          @isActive = false
          @title = page.content_type
          return
        end
      #rescue Mechanize::ResponseCodeError => exception
      rescue Timeout::Error 
        @isActive = false
        return
      rescue StandardError
        #if exception.response_code == '400' or exception.response_code == '500'
          puts StandardError
          @isActive = false
          return
        #end
      end
      @isActive = true
      @title = page.title
      page.links.each do |link| #For every link in the page
        begin
          link.uri.to_s
        rescue StandardError
          #puts StandardError
          next
        end
        @keywords.each do |keyword| #For every keyword provided
          str = "/"+keyword.to_s+"/" #Turn keyword into regexp
          regexp = str.to_regexp
          begin
	    puts (regexp.match(link.uri.to_s).nil? and regexp.match(link.text).nil?)
          rescue StandardError
            next
          end
	  if regexp.match(link.uri.to_s).nil? and regexp.match(link.text).nil?
	  else
            @matched_keywords[keyword] = link #HASH of matched keywords
          end
        end
      end
      @isBusiness = true if @matched_keywords.values.uniq.count >= @quantity_to_match
    else
      @isActive = false
    end
      agent.shutdown
      agent = nil
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
