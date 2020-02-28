class ItemsController < ApplicationController
  before_action :set_item, only: %i(show edit update destroy)
  before_action :find_user
  skip_before_action :authenticate_user!, only: %i(index show)
  before_action :notification_alert

  @@alert = 0

  def index
    if params[:query].present?
      sql_query = "category ILIKE :query OR name ILIKE :query"
      @items = Item.where.not(user: @user)
      @items = @items.where(sql_query, query: "%#{params[:query]}%")
    else
      @items = Item.where.not(user: @user)
      if params[:sort] == "Newest"
        @items = @items.order(:created_at).reverse
      elsif params[:sort] == "Nearest"
       @items = @items.sort_by { |item| @user.item_distance(item) }
      end
    end
  end

  def show
    @exchange = Exchange.new
    if @user
      user_marker = {
        lat: @user.latitude,
        lng: @user.longitude,
        image_url: helpers.asset_url('user_location')
      }
    end
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

  def find_user
    @user = current_user
  end

  def item_params
    params.require(:item).permit(:name, :description, :category, pictures: [])
  end

  def notification_alert
    @user = current_user
    if @user
      if @user.notifications > @@alert
        flash[:notice] = "You received a request for an item!"
        @@alert += 1
      end
    end
  end
end
