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
    	can :index, Item
      can :show, Item

      #look at and update own user info
      can :show, User do |u|
        u.id == user.id
      end 
      can :update, User do |u|
        u.id == user.id
      end 
    elsif user.role? :shipper
    	can :index, Item
      can :show, Item

      #look at and update own user info
      can :show, User do |u|
        u.id == user.id
      end 
      can :update, User do |u|
        u.id == user.id
      end 
    elsif user.role? :customer
      can :index, Item
      can :show, Item

      # can look at and update own user info
      can :show, Customer do |c|
        c.id == user.customer.id
      end 
      can :update, Customer do |c|
        c.id == user.customer.id
      end 

      can :read, Address do |a|
        my_addresses = user.customer.addresses.map(&:id)
        my_addresses.include? a.id
      end

      can :update, Address do |a|
        my_addresses = user.customer.addresses.map(&:id)
        my_addresses.include? a.id
      end

      can :create, Address

      can :read, Order do |o|
        my_orders = user.customer.orders.map(&:id)
        my_orders.include? o.id
      end
      

      can :create, Order
    else
    	can :index, Item
      can :show, Item
      can :create, Customer
     # can :manage, :all
    end




  end
end