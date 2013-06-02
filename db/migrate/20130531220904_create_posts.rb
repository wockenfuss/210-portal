class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :subject, :null => false
      t.text :content, :null => false
      t.integer :user_id, :null => false
      t.references :commentable, :polymorphic => true,  :null => false

      t.timestamps
    end
  end
end
