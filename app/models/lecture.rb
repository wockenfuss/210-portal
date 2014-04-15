class Lecture < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	has_and_belongs_to_many :components
	has_many :lecture_questions
	has_many :comments, :through => :lecture_questions

  validates :name, :presence => true

  attr_accessible :name, :subtitle, :release_date
  attr_accessor :content

  def path(user)
  	lecture_path(self)
  end

  def self.released
  	Lecture.where("release_date < ?", Time.now).order('release_date DESC')
  end

  def released?
    self.release_date < Time.now
  end

  def self.find_with_content(id)
    lecture = Lecture.find(id)
    lecture.content = lecture_content(lecture)
    # create_or_update_questions(lecture) if lecture.content['sections']
    lecture
  end

  private
  def self.lecture_content(lecture)
    path = Rails.root.join('public', 'lectures', "#{lecture.name.downcase.gsub(' ', '_')}.yml")
    YAML.load_file(path) if File.exists?(path)
  end

  def self.create_or_update_questions(lecture)
    questions = lecture.content['sections'].select { |section| section['type'] == 'question'}
    questions.each do |question|
      q = lecture.lecture_questions.find_or_initialize_by_order_index(question['order_index'])
      q.update_attributes(:content => question['content'])
    end
  end

end
