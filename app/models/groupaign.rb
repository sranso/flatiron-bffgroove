class Groupaign < ActiveRecord::Base
  attr_accessible :title
  has_many :campaigns

end
