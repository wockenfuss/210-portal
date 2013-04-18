class Attempt < ActiveRecord::Base
	has_many :responses
	belongs_to :user
	belongs_to :quiz
	accepts_nested_attributes_for :responses, :allow_destroy => true

  attr_accessible :end_time, :quiz_id, :start_time, :user_id, :graded
  validates :quiz_id, :presence => true
  validates :user_id, :presence => true
  validates :start_time, :presence => true

  def completed?
  	!!self.end_time && self.end_time < Time.now
  end

end
