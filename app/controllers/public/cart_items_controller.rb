class Public::CartItemsController < Public::ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }

    items = Item.all.order('created_at DESC')
    @new_items = items.first(3)

    @favorite = Favorite.new

  end

  def create

    @cart_items = current_customer.cart_items


    if @cart_item = @cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i


    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id

    end

    if @cart_item.save
      redirect_to cart_items_path, notice: "カートに商品を追加しました"
    else

      redirect_to request.referer

    end


  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to request.referer, notice: "数量を変更しました"
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "選択した商品を削除しました"
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to request.referer, notice: "商品を全て削除しました"
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
