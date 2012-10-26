require File.dirname(__FILE__) + '/../models/crawler'
class BatchWorker
  include Sidekiq::Worker
  def perform(batch_id,csv_file)
  	batch = Batch.find(batch_id)
    n = 0
  	CSV.parse(csv_file) do |row|
      n +=1
      next if n == 1 or row.join.blank?
      site = batch.sites.build(:url => row[0])
      site.save
      SiteWorker.perform_async(site.id)
    end
    batch.finish_time = DateTime.now
    batch.status = :complete
    batch.save if batch.valid?
  end
end
