class Ability
  include CanCan::Ability

  def initialize(admin)
    admin ||= Admin.new

    if admin.super_admin?
      can :access, :rails_admin
      can :dashboard
      can :index, [Admin, Level, Match, Player]
      can :new, [Admin, Level, Player]
      can :export, [Match, Player]
      can :history, [Admin, Level, Match, Player]
      can :destroy, [Admin, Level, Match, Player]
    else
      can :read, :all
    end
  end
end
