class Comment < ActiveRecord::Base
	belongs_to :commentable, :polymorphic => true
	belongs_to :user

	validates :commentable_id, :presence => true
	validates :commentable_type, :presence => true
	validates :content, :presence => true
	validates :user_id, :presence => true

  attr_accessible :commentable_id, :commentable_type, :content, :user_id
end