class Batch < ActiveRecord::Base
  attr_accessible :finish_time, :keywords, :neg_keywords, :started_time, :status, :min_keywords, :updated_at
  classy_enum_attr :status
  has_many :sites, :dependent => :destroy
  accepts_nested_attributes_for :sites, :reject_if => lambda { |a| a.nil? }, :allow_destroy => true


  def csv_header
    "URL, Active, Business".split(', ')
  end
  
  def total_time(id)
  	if !finish_time.nil?
  	  seconds = Batch.find(id).sites.order("updated_at").last.updated_at - started_time
  	else
  	  #seconds = (DateTime.now.to_datetime - started_time.to_datetime).to_i
  	  seconds = 0
  	end
  	'%d days, %d hours, %d minutes, %d seconds' %
    # the .reverse lets us put the larger units first for readability
    [24,60,60].reverse.inject([seconds]) {|result, unitsize|
      result[0,0] = result.shift.divmod(unitsize)
      result
    }
  end
end
