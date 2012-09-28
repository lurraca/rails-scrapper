class Site < ActiveRecord::Base
  belongs_to :batch
  attr_accessible :scapped, :title, :url, :valid
  
end
