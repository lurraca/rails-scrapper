require 'rubygems'
require 'mechanize'
class Crawler
  def crawl(url,keywords)  #Method will accept URL and Keywords will check each link agaisnt the keyword to detect if is business 
    agent = Mechanize.new
    begin
      page = agent.get(url)
    rescue Mechanize::ResponseCodeError => exception
      if exception.response_code == '400'
        puts "fucked"
        return
      end
    end
    page.links.each do |link| #For every link in the page
      keywords.each do |keyword| #For every keyword provided
        str = "/"+keyword+"/" #Turn keyword into regexp
        regexp = Regexp.new str
        if regexp.match(link.uri.to_s).nil?
          puts link.uri
        else
          puts "Match: "+link.uri.to_s
        end
      end
    end
  end
end
