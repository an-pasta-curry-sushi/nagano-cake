class Public::ItemsController < Public::ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]

  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def rank_index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all

    #ひと月分のランキングページ
    month_order_detail = OrderDetail.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day)
    @month_rank_items = Item.find(month_order_detail.group(:item_id).order('count(item_id) desc').pluck(:item_id))
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
    @favorite = Favorite.new

    if @favorite_id = current_customer.favorites.find_by(item_id: params[:id])
      @favorites = true
    else
      @favorites = false
    end
  end
end
