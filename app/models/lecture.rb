class Lecture < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	has_and_belongs_to_many :components
	has_many :lecture_questions
	has_many :commments, :through => :lecture_questions

  validates :name, :presence => true

  attr_accessible :name, :subtitle, :release_date

  def path(user)
  	lecture_path(self)
  end

  def self.released
  	Lecture.where("release_date < ?", Time.now).order('release_date DESC')
  end

  def released?
    self.release_date < Time.now
  end

end
