class Unit < ActiveRecord::Base
	has_many :lectures
  attr_accessible :close_date, :name, :release_date
  validates :name, :presence => true
end
