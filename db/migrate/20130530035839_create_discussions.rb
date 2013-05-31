class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :content, :null => false
      t.datetime :release_date
      t.datetime :close_date
      t.string :title, :null => false

      t.timestamps
    end
  end
end
