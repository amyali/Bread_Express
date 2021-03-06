class HomeController < ApplicationController
  include BreadExpressHelpers::Baking

  def home
  	# Mainly for bakers and shippers to access their respective lists but also for admin to view all
  	if logged_in? && !current_user.role?(:customer)
  		  @bake_bread = create_baking_list_for("bread")
        @bake_muffins = create_baking_list_for("muffins")
        @bake_pastries = create_baking_list_for("pastries")
        @shipping_list = Order.not_shipped.chronological
    end


  end

  def about
  end

  def privacy
  end

  def contact
  end






end