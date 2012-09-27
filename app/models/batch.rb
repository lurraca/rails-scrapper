class Batch < ActiveRecord::Base
  attr_accessible :finish_time, :keywords, :started_time, :status
  classy_enum_attr :status
end
