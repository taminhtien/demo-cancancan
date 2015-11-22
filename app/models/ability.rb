class Ability
  include CanCan::Ability

  # Default aliases in Can3
  # alias_action :index, :show, :to => :read
  # alias_action :new,          :to => :create
  # alias_action :edit,         :to => :update

  def initialize(user)
    user ||= User.new

    if user.role?(:admin)
      can :manage, :all
    elsif user.role?(:moderator)
      can :create, Project
      can :update, Project do |project|
        project.ongoing?
      end
      can :read, Project
    elsif user.role?(:user)
      can :read, Project, ongoing: true
    end
  end
end
