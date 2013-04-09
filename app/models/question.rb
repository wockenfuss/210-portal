class Question < ActiveRecord::Base
  attr_accessible :content, :correct_answer_id
end
