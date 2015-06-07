class OrderItemsController < ApplicationController
	before_action :check_login
	before_action :set_order_item, only: [:show, :edit, :update, :destroy]
	authorize resource

  def edit
  end

  def index
  	@order_items = OrderItem.all.paginate(:page => params[:page]).per_page(10)
  end

  def new
  	@order_item = OrderItem.new
  end

  def show
  end

  def create
  	@order_item = OrderItem.new(order_item_params)
  	if @order_item.save
  		redirect_to order_items_path, notice: "Order item was added to  the system."
  	else
  		render action: 'new'
  	end
  end

  def update
  	if @order_item.update(order_item_params)
  		redirect_to order_items_path, notice: "Order item was revised in the system."
  	else
  		render action: 'edit'
  	end
  end

  def destroy
  	@order_item.destroy
  	redirect_to order_items_url, notice: "The order item was removed from the system"
  end

  private

  def set_order_item
  	@order_item = OrderItem.find(params[:id])
  end

  def order_item_params
  	params.require(:order_item).permit(:order_id, :item_id, :quantity, :shipped_on)
  end
end
