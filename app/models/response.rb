class Response < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	belongs_to :attempt

	validates :question_id, :presence => true
	validates :user_id, :presence => true
	validates :attempt_id, :presence => true

  attr_accessible :answer_id, :content, :question_id, :user_id, :attempt_id, :points

  def correct_answer?
  	self.answer_id && self.answer_id == self.question.correct_answer_id
  end

  def calculate_points
  	points = self.correct_answer? ? self.question.points : 0
  	self.update_attributes(:points => points)
  	self.points
  end

end
