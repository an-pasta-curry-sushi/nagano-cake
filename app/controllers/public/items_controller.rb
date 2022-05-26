class Public::ItemsController < Public::ApplicationController
  before_action :authenticate_customer!, except: [:index, :show, :search, :sort, :rank_index]

  def index
    @total_items = Item.all
    @items = Item.latest.page(params[:page])
    @genres = Genre.all
  end

  def rank_index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all

    #ひと月分のランキングページ
    month_order_detail = OrderDetail.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day)
    @month_rank_items = Item.page(params[:page]).per(8).find(month_order_detail.group(:item_id).order('count(item_id) desc').pluck(:item_id))
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
    @favorite = Favorite.new

    if customer_signed_in?
      if @favorite_id = current_customer.favorites.find_by(item_id: params[:id])
      @favorites = true
      else
      @favorites = false
      end
    end
  end

  def search
    @genres = Genre.all
    if params[:word]
      @word = params[:word]
      @total_items = Item.where("name LIKE?","%#{@word}%")
    elsif params[:genre]
      @genre = Genre.find(params[:genre])
      @total_items = Item.where(genre_id: @genre.id)
    end
    @items = @total_items.page(params[:page]).per(8)
    render "index"
  end

  def sort
    @total_items = Item.all
    @genres = Genre.all
    case params[:sort_items]
    when "old"
      @items = Item.page(params[:page]).per(8)
    when "high_price"
      @items = Item.order(no_tax_price: "DESC").page(params[:page]).per(8)
    when "low_price"
      @items = Item.order(:no_tax_price).page(params[:page]).per(8)
    else # default(new)
      @items = Item.latest.page(params[:page]).per(8)
    end
  end
end
