class Answer < ActiveRecord::Base
	belongs_to :question
	
  validates :content, :presence => true
  validates :question_id, :presence => true
  attr_accessible :content, :question_id, :index_number

  def self.new_from_question(question, params)
  	params.each do |param|
  		question.answers.create(param[1])
  	end
  end

  def self.update_from_question(params)
    params.each do |param|
      answer = Answer.find(param[1][:id])
      answer.update_attributes(param[1])
    end
  end

  def self.create_answers(question)
    return 4.times.collect { |index| question.answers.build }
  end


end
