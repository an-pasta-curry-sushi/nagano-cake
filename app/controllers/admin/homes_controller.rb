class Admin::HomesController < Admin::ApplicationController

  def top
    @orders = Order.page(params[:page]).latest
  end
end
