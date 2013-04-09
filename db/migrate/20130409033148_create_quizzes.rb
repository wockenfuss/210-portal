class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :duration
      t.datetime :release_date
      t.datetime :close_date

      t.timestamps
    end
  end
end
