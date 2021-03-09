class Ability
  include CanCan::Ability

  def initialize user
    if user.admin?
      can :manage, :all
      cannot :create, Borrowing
      cannot :read, BorrowItem
      cannot :create, BorrowItem
      cannot :destroy, BorrowItem
    else
      can :create, BorrowItem
      can :create, Borrowing
      can :read, Borrowing, user_id: user.id
      can :read, Borrowing, ["user_id = ?", user.id] do |borrowing|
        borrowing.created_at.year >= 2021
      end
      can :read, BorrowItem
    end
  end
end
