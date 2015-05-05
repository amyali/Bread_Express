class ItemsController < ApplicationController
  def edit
  end

  def index
  	@active_items = Item.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  	@inactive_items = Item.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def new
  end

  def show
  end

  private
  def item_params
    params.require(:item).permit(:name, :category, :units_per_item)
  end
end
