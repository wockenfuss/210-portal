module LecturesHelper
	def parse_lecture_name(name)
		new_name = ""
		words = name.split(" ")
		words.each_with_index do |word, index|
			new_name << "_" unless index == 0
			new_name << word.downcase
		end
		new_name
	end

	def parse_lecture_question(lecture, index)
		lecture.lecture_questions.find_by_order_index(index)
	end
end
	