class Public::OrdersController < Public::ApplicationController
  def new
    @order = Order.new
    @customer = current_customer

    unless @customer.cart_items.exists?
      redirect_to items_path, notice: "カートに商品を追加してください"
    end

  end

  def index
    @orders = current_customer.orders.latest.page(params[:page]).per(5)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = @order_details.inject(0) { |sum, order_detail| sum + order_detail.sum_of_price }
  end

  def confirm
    @order = Order.new(order_params)

    @cart_items = current_customer.cart_items

    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    #送料
    @order.shipping_cost = 800
    @total_payment = @total.to_i + @order.shipping_cost
    @order.total_payment = @total_payment

    if params[:order][:delivery_number] == "0"
      @order.name = current_customer.get_full_name(current_customer)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address

    elsif params[:order][:delivery_number] == "1"

      if Delivery.find_by(id: params[:order][:delivery_id])
        @order.name = Delivery.find(params[:order][:delivery_id]).name
        @order.postal_code = Delivery.find(params[:order][:delivery_id]).postal_code
        @order.address = Delivery.find(params[:order][:delivery_id]).address
      else

        render 'new'
      end

    elsif params[:order][:delivery_number] == "2"
      @delivery = Delivery.new(delivery_params)
      @delivery.customer_id = current_customer.id
      if @delivery.save
        flash[:notice] = '新しいお届け先を登録しました'
      else
        render 'new'
      end
    else

      render 'new'

    end

  end

  def create

    @cart_items = current_customer.cart_items
    @order = current_customer.orders.new(order_params)

    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item.id
        @order_detail.price = cart_item.item.get_taxin_price
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end

    redirect_to thanks_order_path

    @cart_items.destroy_all

    else

      render 'new'

    end
  end

  def thanks
    flash[:notice] = ''
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

  def delivery_params
    params.require(:order).permit(:postal_code, :address, :name )

  end
end
