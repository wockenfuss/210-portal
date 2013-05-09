class AddSortNumberToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :sort_number, :integer
  end
end
