class AddAutogradeToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :autograde, :boolean, :default => false
  end
end
