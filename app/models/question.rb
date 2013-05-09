class Question < ActiveRecord::Base
	has_and_belongs_to_many :quizzes, :join_table => :questions_quizzes
	has_many :answers, :dependent => :destroy
	has_many :responses

	validates :content, :presence => true
  validates :points, :presence => true
  # validates :correct_answer_id, :presence => true
  # validates_associated :answers
	accepts_nested_attributes_for :answers, :allow_destroy => true

	before_validation :delete_essay_answers

  attr_accessible :content, :correct_answer_id, :name, :multiple_choice, 
  								:points, :correct_answer, :answers_attributes, :sort_number
	attr_accessor :multiple_choice, :correct_answer

	private
	def delete_essay_answers
		if self.multiple_choice == "false"
			self.answers.each do |answer|
				answer.destroy if answer.content.blank?
			end
		end
	end

end
