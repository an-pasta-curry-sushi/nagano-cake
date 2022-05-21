class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @delivaries = @customer.deliveries
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, order_detail| sum + order_detail.sum_of_price }
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    if params[:order][:delivery_number] == "1"
      @order.name = customer.get_full_name(current_customer)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
    elsif params[:order][:delivery_number] == "2"
      if Delivery.exists?(name: params[:order][:registered])
        @order.name = Delivery.find(params[:order][:registered]).name
        @order.postal_code = Delivery.find(params[:order][:registered]).postal_code
        @order.address = Delivery.find(params[:order][:registered]).address
      else
        render 'new'
      end
    elsif params[:order][:delivery_number] == "3"
      delivery_new = Delivery.new(delivery_params)
      delivery_new.customer_id = current_customer.id
      if delivery_new.save
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def create
    @items = current_customer.cart_items
    @order = Order.new(order_params)
    if @order.save
      @items.each do |item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = item.id
        @order_detail.price = item.get_taxin_price
        @order_detail.amount = item.amount
        @order_detail.save
      end
    redirect_to thanks_order_path
    @items.destroy_all
    else
      render 'new'
    end
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

  def delivery_params
    params.require(:order).permit(:postal_code, :address, :name )

  end
end
