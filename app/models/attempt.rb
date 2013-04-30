class Attempt < ActiveRecord::Base
	has_many :responses, :dependent => :destroy
	belongs_to :user
	belongs_to :quiz
	accepts_nested_attributes_for :responses, :allow_destroy => true

  attr_accessible :end_time, :quiz_id, :start_time, :user_id, :graded, :score#, :released
  # attr_accessor :released
  validates :quiz_id, :presence => true
  validates :user_id, :presence => true
  validates :start_time, :presence => true

  def completed?
  	!!self.end_time && self.end_time < Time.now
  end

  def graded?
    !!self.graded
  end

  def grade!
    score = self.responses.inject(0) do |sum, response|
      sum + response.calculate_points!
    end
    self.update_attributes(:score => score)
    self.update_attributes(:graded => true) if self.quiz.autograde
  end

  def released?
    quiz.released?
  end

  def attempted?
    self.quiz.attempts.where(:user_id => self.user.id).count != 0
  end

end
