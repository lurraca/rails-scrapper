class HomeController < ApplicationController
  require 'csv'
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
  def import
    @settings = Setting
    @keywords = @settings.keywords
    if request.post? && params[:inputfile].present?
      infile = params[:inputfile].read
      n, errors = 0, []
      batch = Batch.create(:status => :started, :keywords => @keywords, :started_time => DateTime.now, :min_keywords => Setting.min_keywords)
      if batch.save
        BatchWorker.perform_async(batch.id,infile)
        redirect_to batch_index_path
      end
    end
  end
end
