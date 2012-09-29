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
      batch.save if batch.valid?
      CSV.parse(infile) do |row|
        n +=1
        next if n == 1 or row.join.blank?
        site = batch.sites.build(:url => row[0])
        if site.valid? #PROBABLY MOVE THIS CODE TO SOMEWHERE ELSE
          @crawler = Crawler.new(site.url, batch.keywords.split(","), batch.min_keywords)
          @crawler.crawl
          site.valid_site = @crawler.isActive
          site.business = @crawler.isBusiness
          site.title = @crawler.title
          site.scapped = true
          site.save
          if @crawler.matched_keywords.count > 0
            @crawler.matched_keywords.each do |key, value|
              matched_link = site.matched_links.build(:keyword => key, :link_text => value.to_s, :link_url => value.uri.to_s)
              matched_link.save
            end
          end
        else
          errors << row
        end
      end
      batch.finish_time = DateTime.now
      batch.status = :complete
      batch.save if batch.valid?
      if errors.any?
        errFile ="errors_#{Date.today.strftime('%d%b%y')}.csv"
        errors.insert(0, Customer.csv_header)
        errCSV = CSV.generate do |csv|
          errors.each {|row| csv << row}
        end
        send_data errCSV,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{errFile}.csv"
      else
        flash[:notice] = I18n.t('customer.import.success')
        redirect_to multi_url #GET
      end
    end
  end
end