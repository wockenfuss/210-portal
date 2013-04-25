class Answer < ActiveRecord::Base
	belongs_to :question
	
  validates :content, :presence => true
  attr_accessible :content, :question_id, :index_number

  def self.new_from_question(question, params)
  	params.each do |_, param|
  		question.answers.create(param)
  	end
  end

  def self.new_answers(question)
    4.times.collect { |_| question.answers.build }
  end

end
