class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :content
      t.integer :answer_id
      t.integer :user_id, :null => false
      t.integer :question_id, :null => false
      t.integer :attempt_id, :null => false

      t.timestamps
    end
  end
end
