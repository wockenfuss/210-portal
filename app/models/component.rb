class Component < ActiveRecord::Base

	belongs_to :unit
	has_and_belongs_to_many :quizzes
	has_and_belongs_to_many :lectures
  has_and_belongs_to_many :discussions

  attr_accessible :component_index, :unit_id

  def element
  	self.lectures.first || self.quizzes.first || self.discussions.first
  end

  def name
  	p self.element.class
  	self.element.name
  end

  def path(user)
  	self.element.path(user)
  end

end
