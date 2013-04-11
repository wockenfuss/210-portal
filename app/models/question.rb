class Question < ActiveRecord::Base
	has_and_belongs_to_many :quizzes#, :join_table => :questions_quizzes
	has_many :answers

  attr_accessible :content, :correct_answer_id
end
