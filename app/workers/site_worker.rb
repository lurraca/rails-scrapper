class SiteWorker
  include Sidekiq::Worker
  def perform(site_id)
    errors = []
    site = Site.find(site_id)
    batch = site.batch
    crawler = Crawler.new(site.url, batch.keywords.split(","), batch.min_keywords)
    crawler.crawl
    site.valid_site = crawler.isActive
    site.business = crawler.isBusiness
    site.title = crawler.title
    site.scapped = true
    site.save
    if crawler.matched_keywords.count > 0
      crawler.matched_keywords.each do |key, value|
        matched_link = site.matched_links.build(:keyword => key, :link_text => value.to_s, :link_url => value.uri.to_s)
        matched_link.save
      end
    crawler = nil
    end
  end
end