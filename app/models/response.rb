class Response < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	belongs_to :attempts

  attr_accessible :answer_id, :content, :question_id, :user_id
end
