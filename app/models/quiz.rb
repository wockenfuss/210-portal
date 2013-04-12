class Quiz < ActiveRecord::Base

	has_and_belongs_to_many :questions#, :join_table => :questions_quizzes
	validates :name, :presence => true
	validates :release_date, :presence => true
	validates :close_date, :quiz_close_date => true

  attr_accessible :close_date, :duration, :release_date, :name

end
