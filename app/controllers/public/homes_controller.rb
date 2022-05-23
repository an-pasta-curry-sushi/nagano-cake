class Public::HomesController < Public::ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]
  
  def top
    @items = Item.latest.limit(4)
    @genres = Genre.all
  end

  def about
  end
end
