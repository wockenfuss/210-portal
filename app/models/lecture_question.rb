class LectureQuestion < ActiveRecord::Base
	belongs_to :lecture
	has_many :comments, :as => :commentable

	validates :content, :presence => true
	validates :lecture_id, :presence => true
	validates :order_index, :presence => true
	
  attr_accessible :content, :lecture_id, :order_index
end
