class ExchangesController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @exchange = Exchange.new
  end

  def create
    @exchange = Exchange.new(exchange_params)
    # we need `restaurant_id` to associate review with corresponding restaurant
    @item = Item.find(params[:item_id])
    @exchange.item = @item
    @exchange.user = current_user
    if @exchange.save
      redirect_to item_path(@item)
    else
      render "/profile"
    end
  end

  def destroy
  end

  private

  def exchange_params
    params.require(:exchange).permit(:location, :date)
  end
end
