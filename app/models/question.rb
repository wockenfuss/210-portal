class Question < ActiveRecord::Base
	has_and_belongs_to_many :quizzes, :join_table => :questions_quizzes
	has_many :answers, :dependent => :destroy
	has_many :responses
	accepts_nested_attributes_for :answers, :allow_destroy => true

  attr_accessible :content, :correct_answer_id, :name, :multiple_choice, :points, :correct_answer
  attr_accessor :multiple_choice, :correct_answer
  validates :content, :presence => true
  validates :points, :presence => true
  validates_associated :answers
end
