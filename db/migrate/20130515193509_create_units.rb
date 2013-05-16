class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.datetime :release_date
      t.datetime :close_date
      t.string :name, :null => false

      t.timestamps
    end
  end
end
