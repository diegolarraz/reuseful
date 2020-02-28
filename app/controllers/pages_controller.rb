class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home profile]
  def home
    @user = current_user
  end

  def profile
    @user = current_user
    @items = @user.items
    @requests = @user.exchanges
    @exchanges = []
    @donations = []
    @items.each do |item|
      unless item.exchanges.last.nil?
        if item.exchanges.last.confirmed && item.exchanges.last.date < Time.now
          @donations << item
        elsif !item.exchanges.last.confirmed
          @exchanges << item.exchanges.last
        end
      end
    end
  end

  def confirm?
    exchange = Exchange.find(params[:exchange])
    exchange.confirmed = true
    exchange.save
    flash[:notice] = "Collection confirmed!"
    redirect_to profile_path
  end
end

