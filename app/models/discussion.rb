class Discussion < ActiveRecord::Base
	has_many :comments, :as => :commentable
  attr_accessible :close_date, :content, :release_date, :name
  validates :name, :presence => true
  validates :content, :presence => true
end
