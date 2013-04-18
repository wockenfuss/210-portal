module AttemptsHelper

	def current_response(attempt, question)
    attempt.responses.where(:question_id => question.id).first || @attempt.responses.build
  end
end
