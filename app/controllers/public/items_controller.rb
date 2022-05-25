class Public::ItemsController < Public::ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]

  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
    @favorite = Favorite.new


    if current_customer.favorites.find_by(item_id: params[:id])
      @favorites = true
    else
      @favorites = false
    end
  end
end
