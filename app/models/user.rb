class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, #:rememberable, 
         :trackable, :validatable, :confirmable

  has_many :attempts
  has_many :responses
  has_one :gradebook
  
  after_create :create_gradebook

  attr_accessible :email, :password, :password_confirmation, :gradebook_id

  def attempted?(quiz)
    self.attempts.where(:quiz_id => quiz.id) != []
  end

  def graded_attempts
    self.attempts.where(:graded => true)
  end

end
