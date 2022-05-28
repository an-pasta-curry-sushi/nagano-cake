class Admin::HomesController < Admin::ApplicationController

  def top
    @orders = Order.latest.page(params[:page])
  end
end
