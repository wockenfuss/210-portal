class CreateLectureQuestions < ActiveRecord::Migration
  def change
    create_table :lecture_questions do |t|
      t.references :lectures, :null => false
      t.string :content, :null => false
      t.integer :order_index, :null => false

      t.timestamps
    end
  end
end
