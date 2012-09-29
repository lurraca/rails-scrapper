class Site < ActiveRecord::Base
  belongs_to :batch
  has_many :matched_links
  attr_accessible :scapped, :title, :url, :valid
    accepts_nested_attributes_for :matched_links, :reject_if => lambda { |a| a.nil? }, :allow_destroy => true
  
end
