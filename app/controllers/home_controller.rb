class HomeController < ApplicationController
  def index
  end
  def single_crawl
  	
  end
  def multi_crawl
  end
  def do_crawl
  	@keywords =[]
  	@keywords = params[:keywords].split(",")
  	@crawler = Crawler.new(params[:url],@keywords)
  	logger.debug "Keywords: " + @keywords.to_s
  	@crawler.crawl
  	@a = @crawler.isBusiness
  	logger.debug "Called business"
  end
end
