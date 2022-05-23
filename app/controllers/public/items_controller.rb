class Public::ItemsController < Public::ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]
  before_action :authenticate_admin!, except: [:index, :show]
  
  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
end
