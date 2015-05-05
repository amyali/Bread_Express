class ItemsController < ApplicationController
  include BreadExpressHelpers::Cart
  before_action :check_login, except:[:show, :index]
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
    @item_prices = ItemPrice.where(item_id: @item.id).paginate(:page => params[:page]).per_page(10)
    @item_price = ItemPrice.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to items_path, notice: "The item was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: "The item was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: "The item was removed from the system"
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :category, :units_per_item)
  end
end
