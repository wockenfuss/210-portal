class AddQuestionsQuizzesJoinTable < ActiveRecord::Migration
	def change
		create_table :questions_quizzes do |t|
      t.integer :question_id
      t.integer :quiz_id

      t.timestamps
    end
	end
end
