class Unit < ActiveRecord::Base
	has_many :components, :order => 'component_index'
	has_many :quizzes, :through => :components
	has_many :lectures, :through => :components
	has_many :discussions, :through => :components

  attr_accessible :close_date, :name, :release_date
  validates :name, :presence => true

  def self.current
		Unit.where("release_date < ?", Time.now).order('release_date DESC')
  end

end
