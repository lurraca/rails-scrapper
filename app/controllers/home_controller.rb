class HomeController < ApplicationController
  def index
  end
  def settings
    @settings = Setting
  end
  def update_settings
    Setting.keywords = params[:keywords]
    Setting.min_keywords = params[:min_keywords].to_i
    redirect_to :back
  end
  def single_crawl
    @settings = Setting
  end
  def multi_crawl
    @settings = Setting
  end
  def do_crawl
    @settings = Setting
  	@keywords =[]
  	@keywords = @settings.keywords.split(",")
  	@crawler = Crawler.new(params[:url],@keywords,Setting.min_keywords)
  	logger.debug "Keywords: " + @keywords.to_s
  	@crawler.crawl
  	@a = @crawler.isBusiness
  	logger.debug "Called business"
  end
end
