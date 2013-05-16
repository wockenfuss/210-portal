class Lecture < ActiveRecord::Base
	belongs_to :unit
  attr_accessible :name, :unit_id
  validates :name, :presence => true
end
