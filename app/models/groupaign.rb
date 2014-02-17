class Groupaign < ActiveRecord::Base
  attr_accessible :title, :campaigns
  has_many :campaigns

end
