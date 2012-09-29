class MatchedLink < ActiveRecord::Base
  belongs_to :site
  attr_accessible :keyword, :link_text, :link_url
end
