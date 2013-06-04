class Quiz < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  has_and_belongs_to_many :components
	has_and_belongs_to_many :questions, :order=>'sort_number ASC'#, :join_table => :questions_quizzes
	has_many :attempts
	
	validates :name, :presence => true
	validates :release_date, :presence => true
	validates :close_date, :quiz_close_date => true

  attr_accessible :close_date, :duration, :release_date, :name, :autograde

  def path(user)
    if user.has_role?(:admin)
      return edit_quiz_path(self)
    else
      return new_attempt_path(self, user)
    end
  end

  def possible_points
  	self.questions.inject(0) { |sum, question| sum + question.points } 
  end

  def released?
  	release_date < Time.now && close_date > Time.now
  end

  def attempted?(user)
    self.attempts.where(:user_id => user.id).count > 0
  end

  def self.released_quizzes
		Quiz.where("release_date < ? AND close_date > ?", Time.now, Time.now)
  end

end
