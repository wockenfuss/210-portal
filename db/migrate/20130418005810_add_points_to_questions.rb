class AddPointsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :points, :integer, :null => false
    add_column :responses, :points, :integer
  end
end
