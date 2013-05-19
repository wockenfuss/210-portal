class Lecture < ActiveRecord::Base
	has_many :lecture_questions
	has_many :commments, :through => :lecture_questions
	belongs_to :unit
  attr_accessible :name, :unit_id
  validates :name, :presence => true
end
