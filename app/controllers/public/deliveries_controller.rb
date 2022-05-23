class Public::DeliveriesController < Public::ApplicationController

  def index
    @deliveries = current_customer.deliveries
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(delivery_params)
    if @delivery.save
      redirect_to deliveries_path, notice: "配送先登録しました"
    else
      @deliveries = current_customer.deliveries
      render 'index'
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to deliveries_path
    else
      render 'edit'
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to request.referer
  end

  private

  def delivery_params
    params.require(:delivery).permit(:postal_code, :address, :name, :customer_id)
  end

end
