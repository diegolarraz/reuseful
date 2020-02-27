class ItemsController < ApplicationController
  before_action :set_item, only: %i(show edit update destroy)
  skip_before_action :authenticate_user!, only: %i(index show)


  def index
    @items = Item.all
    @user = current_user
  end

  def show
    @exchange = Exchange.new
    @user = current_user
    user_marker = {
      lat: @user.latitude,
      lng: @user.longitude,
      image_url: helpers.asset_url('user_location')
    }
    item_marker = {
      lat: @item.user.latitude,
      lng: @item.user.longitude,
      image_url: helpers.asset_url('item_location')
    }
    @markers = [item_marker, user_marker]
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      flash[:notice] = "Thanks! Your item has been added!"
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.save
      flash[:notice] = "Your item has been successfully edited!"
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "Your item has been removed!"
    redirect_to items_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category, pictures: [])
  end
end
