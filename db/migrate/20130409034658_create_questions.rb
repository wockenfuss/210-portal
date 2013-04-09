class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content, :null => false
      t.integer :correct_answer_id

      t.timestamps
    end
  end
end
