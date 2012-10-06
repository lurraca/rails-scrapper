class Site < ActiveRecord::Base
  belongs_to :batch
  has_many :matched_links
  attr_accessible :scapped, :title, :url, :valid
  accepts_nested_attributes_for :matched_links, :reject_if => lambda { |a| a.nil? }, :allow_destroy => true
  def is_valid?
    "x" if self.valid_site
  end
  def is_business?
  	"x" if self.business
  end
end
