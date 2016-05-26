class Ability
  include CanCan::Ability

  def initialize(admin)
    admin ||= Admin.new

    if admin.super_admin?
      can :access, :rails_admin
      can :dashboard
      can :index, [Admin, BracketConfiguration, Level, Match, Player, Tournament]
      can :new, [Admin, BracketConfiguration, Level, Match, Player, Tournament]
      can :start_tournament, [Tournament]
      can :list_tournament_players, [Tournament]
      can :add_player, [Tournament]
      can :remove_player, [Tournament]
      can :show_in_app, [Tournament]
      can :edit, [Admin, BracketConfiguration, Level, Match, Player, Tournament]
      can :export, [Player]
      can :history, [Admin, Level, Match, Player, Tournament]
      can :destroy, [Admin, BracketConfiguration, Level, Match, Tournament]
    else
      can :read, :all
    end
  end
end
