class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to my_page_customers_path
    else
      render "edit"
    end
  end

  def quit_check
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    if @customer.update(is_active: false)
      reset_session
      redirect_to root_path
    else
      render "quit_check"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_easy, :first_name_easy, :postal_code, :address, :phone_number, :email)
  end

end
