class ItemPricesController < ApplicationController
	before_action :check_login
	before_action :check_login, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def index
  	@item_prices = ItemPrice.chronological.paginate(:page => params[:page]).per_page(10)
  end

  def new
  	@item = Item.find(params[:item_id])
  	@item_price = ItemPrice.new
  end

  def show
  end

  def create
  	@item_price = ItemPrice.new(item_price_params)
  	respond_to do |format|
  		if @item_price.save
  			format.html { redirect_to item_path(@item_price.item), notice: 'Item price was successfully created.'}
  			format.json { render action: 'show', status: :created, location: @item_price}
  		else
  			format.html {render action: 'new' }
  			format.json { render json: @item_price.errors, status: :unprocessable_entity}
  		end
  	end
  end

  def update
  	respond_to do |format|
  		if @item_price.update(item_price_params)
  			format.html { redirect_to @item_price, notice: 'Item price was successfully updated.'}
  			format.json { head :no_content }
  		else
  			format.html { render action: 'edit'}
  			format.json {render json: @item_price.errors, status: :unprocessable_entity}
  		end
  	end
  end

  def destroy
  	@item_price_destroy
  	respond_to do |format|
  		format.html { redirect_to item_prices_url }
  		format.json { head :no_content}
  	end
  end

  private

  def set_item_price
  	@item_price = ItemPrice.find(params[:id])
  end

  def item_price_params
  	params.require(:item_price).permit(:item_id, :price, :start_date, :end_date)
  end
end
