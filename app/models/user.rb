class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable,
         :trackable, :validatable#, :confirmable

  has_many :attempts
  has_many :responses
  has_one :gradebook
  has_many :comments
  
  after_create :create_gradebook
  attr_accessible :email, :password, :password_confirmation

  def attempted?(quiz)
    self.attempts.where(:quiz_id => quiz.id) != []
  end

  def graded_attempts
    self.attempts.where(:graded => true)
  end

end
