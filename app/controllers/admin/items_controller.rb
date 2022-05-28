class Admin::ItemsController < Admin::ApplicationController
  def index
    @items = Item.latest.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を追加しました"
    else
      render "new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path, notice: "商品を更新しました"
    else
      render "edit"
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def search
    @word = params[:word]
    @total_items = Item.where("name LIKE?","%#{@word}%")
    @items = @total_items.page(params[:page])
    render "index"
  end

  def sort
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
  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :item_image, :no_tax_price, :salling_status, :genre_id)
  end
end
