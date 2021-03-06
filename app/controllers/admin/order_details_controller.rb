class Admin::OrderDetailsController < Admin::ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(params[:order_id])
    @order_details = @order.order_details
    if @order_detail.update(order_detail_params)

      if @order_detail.making_status == "making"
        @order_detail.order.update(status: 2)
      elsif @order_details.all? { |order_detail|order_detail.making_status == "complete" }
        @order_detail.order.update(status: 3)
      end
      @order = Order.find(params[:order_id])
      @order_details = @order.order_details
      flash.now[:notice] = "製作ステータスを更新しました"
      render :update
    else
      @order = Order.find(params[:order_id])
      @order_details = @order.order_details
      render :update
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
