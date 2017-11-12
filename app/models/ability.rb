class Ability
  include CanCan::Ability

  def initialize(user)
    # if user.nil?
    #     can :read, :all
    # elsif user.role? "admin"
    #     can :manage, :all
    # elsif user.role? "host"
    #     can :read, [Amenity, Room, City]
    #     can :create, Room
    #     can [:update, :destroy], Room do |room|
    #       room.user_id == user.id
    #     end
    # elsif user.role? "guest"
    #     can :read, [Amenity, Room, City]
    # end

    if user.nil?
      can :read, :all
      can :path_change, City
    elsif 
      user.role?("guest")
      can :read, :all
      can :create, Room
      can :create, Booking
      can :path_change, City
      can :create, Review
      can :destroy, Review do |review|
        review.user_id == user.id
      end
    elsif user.role?("host")
      can :read, :all
      can :create, Room
      can :my_rooms, Room
      can [:create, :update, :unconfirmed], Booking
      can [:update, :destroy], Room do |room|
       room.user_id == user.id
      end
      can :host, Booking
      can :create, SpecialPrice
      can :path_change, City
      can :destroy, [Review], :room => { :user_id => user.id }
      can :check_bookings, Room
    elsif user.role?("admin")
      can :manage, :all
      # can [rooms], :admins
      # can :rooms, [Admin] #if user.admin?
    end

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
  end
end

# can [:hello, :goodbye], :say


# authorize_resource class: false