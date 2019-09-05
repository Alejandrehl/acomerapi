class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # por si el usuario no hizo sign in 

    if user.has_role? :admin
      can :manage, Branch
      can :manage, Restaurant
      can :manage, Menu
      can :manage, Category
      can :manage, Product
      can :manage, Order
      can :manage, Review
      can :manage, User
      can :manage, Table
      can :manage, :user
    end

    if user.has_role? :operations
      can :manage, Branch
      can :manage, Restaurant
      can :manage, Menu
      can :manage, Category
      can :manage, Product
      can :manage, Order
      can :manage, Review
      can :manage, Post
      can :manage, PostCategory
      can :manage, FeaturedBranch
      can :manage, Role
      can :manage, Table
    end

    if user.has_role? :waiter
      can :manage, Product
      can :manage, Order
      can :manage, Review
    end

    if user.has_role? :branch_leader
      can :manage, Branch
      can :manage, Menu
      can :manage, Category
      can :manage, Product
      can :manage, Order
      can :manage, Review
      can :manage, User
      can :manage, Table
    end

  end
end
