class Question < ActiveRecord::Base
	has_and_belongs_to_many :quizzes, :join_table => :questions_quizzes
	has_many :answers
	has_many :responses

  attr_accessible :content, :correct_answer_id, :name, :multiple_choice, :points
  attr_accessor :multiple_choice
  validates :content, :presence => true
end
