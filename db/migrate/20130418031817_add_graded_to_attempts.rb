class AddGradedToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :graded, :boolean, :default => false
  end
end
