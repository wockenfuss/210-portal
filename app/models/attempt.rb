class Attempt < ActiveRecord::Base
	has_many :responses, :dependent => :destroy
	belongs_to :user
	belongs_to :quiz
	accepts_nested_attributes_for :responses, :allow_destroy => true

  attr_accessible :end_time, :quiz_id, :start_time, :user_id, :graded, :score
  validates :quiz_id, :presence => true
  validates :user_id, :presence => true
  validates :start_time, :presence => true

  def completed?
  	!!self.end_time && self.end_time < Time.now
  end

  def graded_points
    self.responses.inject(0) { |sum, response| sum + response.points }
  end

  def graded?
    !!self.graded
  end

  def grade
    score = 0
    self.responses.each do |response|
      # response.calculate_points
      if response.correct_answer?
        response.points = response.question.points
      else
        response.points = 0
      end
      score += response.points
    end
    self.update_attributes(:score => score)
    self.update_attributes(:graded => true) if self.quiz.autograde
  end
end
