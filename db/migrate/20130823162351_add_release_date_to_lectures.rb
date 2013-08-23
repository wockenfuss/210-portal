class AddReleaseDateToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :release_date, :datetime
  end
end
