class AddNameToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :name, :string, :null => false
  end
end
