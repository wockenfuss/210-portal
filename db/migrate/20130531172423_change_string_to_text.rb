class ChangeStringToText < ActiveRecord::Migration
  def up
  	change_column :answers, :content, :text
  	change_column :comments, :content, :text
  	change_column :discussions, :content, :text
  	change_column :lecture_questions, :content, :text
  	change_column :questions, :content, :text
  	change_column :responses, :content, :text
  end

  def down
  	change_column :answers, :content, :string
  	change_column :comments, :content, :string
  	change_column :discussions, :content, :string
  	change_column :lecture_questions, :content, :string
  	change_column :questions, :content, :string
  	change_column :responses, :content, :string
  end
end
