class ItemsController < ApplicationController
  include BreadExpressHelpers::Cart
  include BreadExpressHelpers::Shipping
  # before_action :check_login, except:[:show, :index]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def edit
  end

  def index
    @items = Item.alphabetical.paginate(:page => params[:page]).per_page(10)
  	@active_items = Item.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  	@inactive_items = Item.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def new
    @item = Item.new
  end

  def show
    items = Item.alphabetical
    if !(items.empty?)
      @similar_items = items.where(category: @item.category).where.not(name: @item.name)
    end
    @item_prices = ItemPrice.where(item_id: @item.id).paginate(:page => params[:page]).per_page(10)
    @item_price = ItemPrice.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: "#{@item.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "#{@item.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: "#{@item.name} was removed from the system"
  end

  def add_to_cart
    @item = Item.find(params[:id])
    add_item_to_cart(@item.id)
    redirect_to cart_list_path, notice: "#{@item.name} was added to your cart."
  end

  def remove_from_cart
    remove_item_from_cart(params[:id].to_i)
    redirect_to cart_list_path
  end

  def cart_list
    @order_items = get_list_of_items_in_cart
    @shipping_cost = calculate_cart_shipping
    @items_cost = calculate_cart_items_cost
    @total = calculate_cart_items_cost + calculate_cart_shipping
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category, :units_per_item, :weight, :picture, :active)
  end
end
