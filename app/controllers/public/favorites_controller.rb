class Public::FavoritesController < Public::ApplicationController

  def index
    @favorites = current_customer.favorites.page(params[:page]).per(5)
    @cart_item = CartItem.new
  end

  def create
    @favorites = current_customer.favorites

    if @favorites.find_by(item_id: params[:favorite][:item_id])
      redirect_to request.referer, alert: "欲しいものリストにはすでにその商品は存在しています"
    else
      @favorite = Favorite.new(favorite_params)
      @favorite.customer_id = current_customer.id
      if @favorite.save
        flash.now[:notice] = "欲しいものリストに商品を追加しました"

        @favorites = true
        @favorite_id = current_customer.favorites.find_by(item_id: params[:favorite][:item_id])
        @cart_items = current_customer.cart_items
        @favorite = Favorite.new
        @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
        render :create_favorite
      else
        redirect_to request.referer
      end
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @item = Item.find(@favorite.item_id)
    @favorite_id = current_customer.favorites.find_by(item_id: @favorite.item_id)
    @favorite.destroy
    flash.now[:alert] = "選択した商品を削除しました"

    @favorites = false
    @favorite = Favorite.new
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @favorites_all = current_customer.favorites
    @cart_item = CartItem.new
    render :destroy_favorite
  end

  def destroy_all
    current_customer.favorites.destroy_all
    redirect_to request.referer, notice: "商品を全て削除しました"
  end

  private

  def favorite_params
    params.require(:favorite).permit(:item_id, :customer_id)
  end


end
