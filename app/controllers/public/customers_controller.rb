class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
   
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to my_page_customers
    else
      render "edit"
    end
  end

  def quit_check
  end

  def withdraw
  end
end
