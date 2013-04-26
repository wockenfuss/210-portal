class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, User
      cannot :read, User do |this_user|
        this_user.id != user.id
      end
      can :read, Gradebook, :user => { :id => user.id }
    end
  end
end
