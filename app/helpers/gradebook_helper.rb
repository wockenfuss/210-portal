module GradebookHelper

	def calculated_grade(attempt)
		"#{attempt.graded_points} / #{attempt.quiz.possible_points}"
	end

end