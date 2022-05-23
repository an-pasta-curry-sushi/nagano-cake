class Admin::OrderDetailsController < Admin::ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(params[:order_id])
    @order_details = @order.order_details
    if @order_detail.update(order_detail_params)

      if @order_detail.making_status == "making"
        @order_detail.order.update(status: 2)
      elsif @order_details.all? { |order_detail|order_detail.making_status == "complete" }
        @order.update(status: 3)
      end

      redirect_to request.referer, notice: "製作ステータス更新しました"
    else
      @order = Order.find(params[:order_id])
      @order_details = @order.order_details
      render admin_order_path(oreder_id: @order.id)
    end
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
