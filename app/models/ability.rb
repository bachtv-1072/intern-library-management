class Ability
  include CanCan::Ability

  def initialize user
    if user.admin?
      can :manage, :all
      cannot :create, Borrowing
      cannot :create, Borrowing, user_id: user.id
      cannot :read, Borrowing
    else
      can :create, Borrowing
      can :read, Borrowing, user_id: user.id
      can :read, Borrowing, ["user_id = ?", user.id] do |borrowing|
        borrowing.created_at.year >= 2021
      end
    end
  end
end
