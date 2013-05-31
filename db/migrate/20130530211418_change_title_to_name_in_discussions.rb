class ChangeTitleToNameInDiscussions < ActiveRecord::Migration
  def up
  	rename_column :discussions, :title, :name
  end

  def down
  	rename_column :discussions, :name, :title
  end
end
