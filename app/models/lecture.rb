class Lecture < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	has_and_belongs_to_many :components

	has_many :lecture_questions
	has_many :commments, :through => :lecture_questions
  attr_accessible :name, :unit_id
  validates :name, :presence => true

  def path(user)
  	lecture_path(self)
  end

end
