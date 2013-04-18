class Response < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	belongs_to :attempt

	validates :question_id, :presence => true
	validates :user_id, :presence => true
	validates :attempt_id, :presence => true
	validates :content, :presence => true

  attr_accessible :answer_id, :content, :question_id, :user_id, :attempt_id
end
