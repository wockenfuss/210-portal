class Attempt < ActiveRecord::Base
	belongs_to :user
  attr_accessible :end_time, :quiz_id, :start_time, :user_id
end
