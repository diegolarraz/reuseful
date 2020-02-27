class ItemsController < ApplicationController
  before_action :set_item, only: %i(show edit update destroy)
  skip_before_action :authenticate_user!, only: %i(index show)


  def index
    if params[:query].present?
      sql_query = "category ILIKE :query OR name ILIKE :query"
      @items = Item.where(sql_query, query: "%#{params[:query]}%")
    else
      @items = Item.all
      @user = current_user
    end
  end

  def show
    @exchange = Exchange.new
    @user = current_user
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
