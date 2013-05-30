class AddSubtitleToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :subtitle, :string
  end
end
