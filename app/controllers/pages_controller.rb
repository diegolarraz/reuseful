class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home profile]
  def home
  end

  def profile
    @user = current_user
    @items = @user.items
    @requests = @user.exchanges
    @exchanges = []
    @donations = []
    @availables = []
    @items.each do |item|
      if item.exchanges.last.nil?
        @availables << item
      else
        if item.exchanges.last.confirmed
          @donations << item
        else
          @exchanges << item.exchanges.last
        end
      end
    end
  end

  def confirm?
    exchange = Exchange.find(params[:exchange])
    exchange.confirmed = true
    exchange.save
    redirect_to profile_path
  end

end
