class ItemsController < ApplicationController
  before_action :set_item, only: %i(show edit update destroy)
  before_action :find_user
  skip_before_action :authenticate_user!, only: %i(index show)


  def index
    @items = Item.all
  end

  def show
    @exchange = Exchange.new

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

  def find_user
    @user = current_user
  end

  def item_params
    params.require(:item).permit(:name, :description, :category, pictures: [])
  end
end
