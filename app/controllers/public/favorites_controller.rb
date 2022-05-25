class Public::FavoritesController < Public::ApplicationController

  def index
    @favorites = current_customer.favorites
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
        redirect_to request.referer, notice: "欲しいものリストに商品を追加しました"
      else
        redirect_to request.referer
      end
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to request.referer, notice: "選択した商品を削除しました"
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
