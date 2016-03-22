class Ability
  include CanCan::Ability

  def initialize(admin)
    admin ||= Admin.new

    if admin.super_admin?
      can :access, :rails_admin
      can :dashboard
      can :index, [Admin, Level, Match, Player, Tournament]
      can :new, [Admin, Level, Match, Player, Tournament]
      can :edit, [Admin, Level, Match, Player, Tournament]
      can :export, [Player]
      can :history, [Admin, Level, Match, Player, Tournament]
      can :destroy, [Admin, Level, Match, Tournament]
    else
      can :read, :all
    end
  end
end
