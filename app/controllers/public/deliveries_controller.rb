class Public::DeliveriesController < Public::ApplicationController

  def index
    @deliveries = current_customer.deliveries
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(delivery_params)
    if @delivery.save
      @deliveries = current_customer.deliveries
      @delivery = Delivery.new
      flash[:notice] = '新しいお届け先を登録しました'
      render :create_delivery
    else
      @deliveries = current_customer.deliveries
      render :error
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to deliveries_path, notice: "お届け先の情報を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    @deliveries = current_customer.deliveries
    @delivery = Delivery.new
    flash[:alert] = '選択したお届け先を削除しました'
    render :create_delivery
  end

  private

  def delivery_params
    params.require(:delivery).permit(:postal_code, :address, :name, :customer_id)
  end

end
