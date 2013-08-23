class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :quiz_taker
      can :create, Attempt, :user_id => user.id, :released? => true, :attempted? => false
      can [:read, :update], Attempt, :user_id => user.id
      can [:read, :update], User, :id => user.id
      can :read, Gradebook, :user => { :id => user.id }
    else
      can :read, User
      cannot :read, User do |this_user|
        this_user.id != user.id
      end
      can :read, Gradebook, :user => { :id => user.id }
      can :create, Attempt, :user_id => user.id, :released? => true, :attempted? => false
      cannot :any, Discussion
      can :read, Lecture, :released? => true
    end
  end
end
