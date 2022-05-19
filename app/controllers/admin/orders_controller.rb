class Admin::OrdersController < ApplicationController
  
  def index
    
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to request.referer
    else
      @order_details = @order.order_details
      render 'show'
    end
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
end
