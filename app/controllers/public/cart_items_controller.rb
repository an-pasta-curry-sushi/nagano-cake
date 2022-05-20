class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create

    @cart_items = current_customer.cart_items
    @cart_item = CartItem.new(cart_item_params)

    if @cart_items = @cart_items.find_by(item_id: @cart_item.item_id)
      @cart_items.amount = @cart_item.amount.to_i + @cart_items.amount.to_i
      @cart_items.save

    else
      @cart_item.customer_id = current_customer.id
      @cart_item.save
    end
    redirect_to cart_items_path

  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
