class Admin::OrdersController < Admin::ApplicationController

  def index
    @customer = Customer.find(params[:customer_id])
    @orders = Order.where(customer_id: params[:customer_id]).latest.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "confirm"
        @order.order_details.update(making_status: 1)
      end
      @order = Order.find(params[:id])
      @order_details = @order.order_details
      flash.now[:notice] = "注文ステータスを更新しました"
      render :update
    else
      @order_details = @order.order_details
      render 'show'
    end
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
