class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :name, :null => false
      t.references :unit

      t.timestamps
    end
  end
end
