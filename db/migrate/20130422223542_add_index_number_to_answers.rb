class AddIndexNumberToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :index_number, :integer, :null => false
  end
end
