class Admin::OrdersController < Admin::ApplicationController

  def index

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
      redirect_to request.referer, notice: "注文ステータスを更新しました"
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
