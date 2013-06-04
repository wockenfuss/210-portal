class Discussion < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	has_many :comments, :as => :commentable
	has_many :posts, :as => :commentable

  validates :name, :presence => true
  validates :content, :presence => true
  	
  attr_accessible :close_date, :content, :release_date, :name


  def path(user)
  	discussions_path
  end

  def self.released
  	Discussion.where("release_date < ?", Time.now).order('release_date DESC')
  end
end
