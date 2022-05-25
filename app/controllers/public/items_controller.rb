class Public::ItemsController < Public::ApplicationController
  before_action :authenticate_customer!, except: [:index, :show, :search, :sort]

  def index
    @total_items = Item.all
    @items = Item.latest.page(params[:page])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
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
    @items = @total_items.page(params[:page])
    render "index"
  end

  def sort
    @total_items = Item.all
    @genres = Genre.all
    case params[:sort_items]
    when "old"
      @items = Item.page(params[:page])
    when "high_price"
      @items = Item.order(no_tax_price: "DESC").page(params[:page])
    when "low_price"
      @items = Item.order(:no_tax_price).page(params[:page])
    else # default(new)
      @items = Item.latest.page(params[:page])
    end
    render "index"
  end
end
