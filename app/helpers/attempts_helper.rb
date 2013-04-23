module AttemptsHelper

	def current_response(attempt, question)
    attempt.responses.where(:question_id => question.id).first || @attempt.responses.build
  end

  def grade_question(question, response)
  	if question.correct_answer_id == response.answer_id
  		return question.points
  	else
  		return 0
  	end
  end
end
