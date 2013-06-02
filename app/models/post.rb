class Post < ActiveRecord::Base
	belongs_to :commentable, :polymorphic => true
	belongs_to :user
	has_many :posts, :as => :commentable

	validates :commentable_id, :presence => true
	validates :commentable_type, :presence => true
	validates :content, :presence => true
	validates :user_id, :presence => true

  attr_accessible :commentable_id, :commentable_type, :content, :subject, :user_id
end
