class Attempt < ActiveRecord::Base
	has_many :responses
	belongs_to :user
	belongs_to :quiz
	
  attr_accessible :end_time, :quiz_id, :start_time, :user_id

  def completed?
  	!!self.end_time && self.end_time < Time.now
  end
end
