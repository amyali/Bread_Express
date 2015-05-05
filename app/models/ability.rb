class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all

    elsif user.role? :baker
    	can :manage, :all
    elsif user.role? :shipper
    	can :manage, :all
    elsif user.role? :customer
    	can :index, User

    	can :show, User do |u|
    		u.id == user.id
    	end

    	can :update, User do |u|
    		u.id == user.id
    	end
    else
    	can :manage, :all
    end




  end
end