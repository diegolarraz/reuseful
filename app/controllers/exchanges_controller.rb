class ExchangesController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @exchange = Exchange.new
  end

  def create
    @exchange = Exchange.new(exchange_params)
    @item = Item.find(params[:item_id])
    @exchange.item = @item
    @exchange.user = current_user
    if @exchange.save
      redirect_to profile_path
    else
      @user = current_user
      render 'items/show'
    end
  end

  def destroy
    @exchange = Exchange.find(params[:id])
    @exchange.destroy
    flash[:notice] = "The collection has been removed!"
    redirect_to profile_path
  end

  private

  def exchange_params
    params.require(:exchange).permit(:location, :date)
  end
end
