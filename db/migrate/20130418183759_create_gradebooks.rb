class CreateGradebooks < ActiveRecord::Migration
  def change
    create_table :gradebooks do |t|
      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
