class Public::DeliveriesController < ApplicationController
  
  def index
    @deriveries = current_customer.deriveries
    @derivery = Derivery.new
  end

  def create
    @derivery = Derivery.new(derivery_params)
    if @derivery.save
      redirect_to request.referer
    else
      render 'index'
    end
  end

  def edit
    @derivery = Derivery.find(params[:id])
  end

  def update
    @derivery = Derivery.find(params[:id])
    if @derivery.update(derivery_params)
      redirect_to deriveries_path
    else
      render 'edit'
    end
  end

  def destroy
    @derivery = Derivery.find(params[:id])
    @derivery.destroy
    redirect_to request.referer
  end

  private

  def derivery_params
    params.require(:derivery).permit(:postal_code, :address, :name)
  end

end
