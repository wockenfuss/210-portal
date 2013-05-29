class RemoveUnitIdFromLectures < ActiveRecord::Migration
  def up
    remove_column :lectures, :unit_id
  end

  def down
    add_column :lectures, :unit_id, :integer
  end
end
